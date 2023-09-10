package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
	"time"

	"github.com/jmoiron/sqlx"
	"github.com/labstack/echo/v4"
	_ "github.com/lib/pq"
)

var db *sqlx.DB

func InitializeDatabase() error {
	// Define the database connection string
	dbConnStr := "postgres://bms_user:bms_password@bms_postgres:5432/bms_db?sslmode=disable"

	// Retry database connection for up to 10 times with a 1-second interval
	retries := 10
	for i := 1; i <= retries; i++ {
		fmt.Printf("Attempt %d to establish a database connection...\n", i)

		var err error
		// Open a connection to the database
		db, err = sqlx.Open("postgres", dbConnStr)
		if err != nil {
			fmt.Printf("Error connecting to the database: %v\n", err)
		} else if err := db.Ping(); err == nil {
			fmt.Println("Database connection established successfully")
			return nil
		}

		fmt.Println("db", db)

		// Wait for 1 second before the next retry
		time.Sleep(1 * time.Second)
	}

	return fmt.Errorf("Failed to establish a database connection after %d retries", retries)
}

func fetchLocation(address string) (float64, float64, error) {
	// Replace with your Google Maps Geocoding API key
	apiKey := "AIzaSyDEdq504CIILVVyU7DR9xqjdO9ywM8BQAw"

	// Build the URL for the Geocoding API request
	url := fmt.Sprintf("https://maps.googleapis.com/maps/api/geocode/json?address=%s&key=%s", address, apiKey)

	// Send an HTTP GET request to the Google Maps Geocoding API
	response, err := http.Get(url)
	if err != nil {
		return 0, 0, err
	}
	defer response.Body.Close()

	// Read the response body
	body, err := ioutil.ReadAll(response.Body)
	if err != nil {
		return 0, 0, err
	}
	fmt.Print("reposne body", body)
	// Parse the JSON response
	var result map[string]interface{}
	err = json.Unmarshal(body, &result)
	if err != nil {
		return 0, 0, err
	}

	// Check if the API request was successful
	if status, ok := result["status"].(string); !ok || status != "OK" {
		return 0, 0, fmt.Errorf("Geocoding API request failed with status: %s", status)
	}

	// Extract the latitude and longitude from the response
	if results, ok := result["results"].([]interface{}); ok && len(results) > 0 {
		if geometry, ok := results[0].(map[string]interface{})["geometry"].(map[string]interface{}); ok {
			if location, ok := geometry["location"].(map[string]interface{}); ok {
				latitude := location["lat"].(float64)
				longitude := location["lng"].(float64)
				return latitude, longitude, nil
			}
		}
	}

	return 0, 0, fmt.Errorf("Location not found")
}

func main() {
	dberr := InitializeDatabase()
	if dberr != nil {
		fmt.Printf("Error initializing database: %v\n", dberr)
		os.Exit(1)
	}

	// Create an Echo instance
	e := echo.New()

	// Define a route for the GET endpoint to fetch cities
	e.GET("/bms/api/cities", func(c echo.Context) error {
		// Query the "city" table to retrieve all cities
		var cities []City // Create a struct to represent the city table row

		// Perform the SELECT query
		query := "SELECT * FROM bms_schema.city"
		if err := db.Select(&cities, query); err != nil {
			fmt.Printf("Error querying the database: %v\n", err)
			return c.JSON(http.StatusInternalServerError, "Internal server error")
		}

		// Return the list of cities as JSON
		return c.JSON(http.StatusOK, cities)
	})

	// Define a route for the GET endpoint to display a welcome message
	e.GET("/bms/api", func(c echo.Context) error {
		// Get the client's IP address
		clientIP := c.Request().RemoteAddr

		// Log the client's IP address
		fmt.Printf("Request from: %s\n", clientIP)

		// Return a response
		return c.JSON(http.StatusOK, "Welcome !! Book your Movie Tickets...")
	})

	// Define a route for the POST endpoint to fetch location
	e.POST("/get-location", func(c echo.Context) error {
		// Read the address from the request body
		body, err := ioutil.ReadAll(c.Request().Body)
		if err != nil {
			return c.JSON(http.StatusBadRequest, map[string]string{"error": "Invalid request body"})
		}

		// Convert the JSON request body to a struct
		var request struct {
			Address string `json:"address"`
		}
		err = json.Unmarshal(body, &request)
		if err != nil {
			return c.JSON(http.StatusBadRequest, map[string]string{"error": "Invalid JSON request body"})
		}

		// Fetch the location using the Google Maps Geocoding API
		latitude, longitude, err := fetchLocation(request.Address)
		if err != nil {
			return c.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to fetch location"})
		}

		// Create a response struct
		response := LocationResponse{
			Latitude:  latitude,
			Longitude: longitude,
		}

		// Return the location as JSON response
		return c.JSON(http.StatusOK, response)
	})

	// Start the server
	err := e.Start(":8080")
	if err != nil {
		fmt.Printf("Error starting server: %v\n", err)
	}
}

// Define a struct to represent the "city" table row
type City struct {
	ID        int     `db:"id"`
	Name      string  `db:"name"`
	Latitude  float64 `db:"latitude"`
	Longitude float64 `db:"longitude"`
}

type LocationResponse struct {
	Latitude  float64 `json:"latitude"`
	Longitude float64 `json:"longitude"`
}
