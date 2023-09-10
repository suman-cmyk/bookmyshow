package shared

import (
	"fmt"
	"time"

	"github.com/jmoiron/sqlx"
)

var db *sqlx.DB

func InitializeDatabase() error {
	// Define the database connection string
	dbConnStr := "postgres://bms_user:bms_password@bms_postgres:5432/bms_db?sslmode=disable"

	// Retry database connection for up to 10 times with a 1-second interval
	retries := 10
	for i := 1; i <= retries; i++ {
		fmt.Printf("Attempt %d to establish a database connection...\n", i)

		// Open a connection to the database
		db, err := sqlx.Open("postgres", dbConnStr)
		if err != nil {
			fmt.Printf("Error connecting to the database: %v\n", err)
		} else if err := db.Ping(); err == nil {
			fmt.Println("Database connection established successfully")
			return nil
		}

		// Wait for 1 second before the next retry
		time.Sleep(1 * time.Second)
	}

	return fmt.Errorf("Failed to establish a database connection after %d retries", retries)
}
