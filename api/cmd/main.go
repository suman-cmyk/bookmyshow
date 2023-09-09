package main

import (
	"fmt"
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
