package main

import (
	"fmt"
	"net/http"

	"github.com/labstack/echo/v4"
)

func main() {
	// Create an Echo instance
	e := echo.New()

	// Define a route for the GET endpoint
	e.GET("/bms/api", func(c echo.Context) error {
		// Get the client's IP address
		clientIP := c.Request().RemoteAddr

		// Log the client's IP address
		fmt.Printf("Request from: %s\n", clientIP)

		// Return a response
		return c.String(http.StatusOK, "Hello, World!")
	})

	// Start the server
	err := e.Start(":8080")
	if err != nil {
		fmt.Printf("Error starting server: %v\n", err)
	}
}
