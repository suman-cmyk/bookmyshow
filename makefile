
# Include the environment variables from .env file
include .env

# Makefile for Flyway Clean

# Define the destination directory
DEST_DIR := ./flyway-migration

# Define the Flyway container name
FLYWAY_CONTAINER := ${FLYWAY_CONTAINER_NAME}

.PHONY: flyway-clean

flyway-clean:
	# Remove the existing destination directory
	rm -r $(DEST_DIR)
	
	# Create the destination directory
	mkdir -p $(DEST_DIR)
	
	# Copy the Flyway report from the container to the destination directory
	docker cp $(FLYWAY_CONTAINER):/flyway/report.html $(DEST_DIR)

	# Provide a success message
	@echo "Flyway clean completed. Flyway report copied to $(DEST_DIR)."

