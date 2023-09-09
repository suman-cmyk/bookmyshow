# Makefile for generating API handlers from OpenAPI spec

# Variables
OPENAPI_SPEC := ./openapi/openapi.yaml
GENERATED_DIR := ./internal
PACKAGE_NAME := internal
OAPI_CODEGEN_VERSION := $(shell oapi-codegen version 2>&1 || echo "Not installed")

# Define the installation command based on the package manager (you can adjust this based on your system)
INSTALL_CMD := go get -u github.com/deepmap/oapi-codegen/cmd/oapi-codegen

# Create the generated directory if it doesn't exist
#$(shell mkdir -p $(GENERATED_DIR))

# Target to install oapi-codegen if not installed
install-oapi-codegen:
	@echo "Checking if oapi-codegen is installed..."
	@if [ "$(OAPI_CODEGEN_VERSION)" == "Not installed" ]; then \
		echo "oapi-codegen is not installed. Installing it now..."; \
		$(INSTALL_CMD); \
	else \
		echo "oapi-codegen is already installed (version: $(OAPI_CODEGEN_VERSION))."; \
	fi

# Generate API handlers
generate-api-handler: install-oapi-codegen
	@echo "oapi-codegen version: $(OAPI_CODEGEN_VERSION)"
	@echo "Generating API handlers..."
	@oapi-codegen -generate "chi-server" -package $(PACKAGE_NAME) $(OPENAPI_SPEC) > $(GENERATED_DIR)/handlers.gen.go
	@echo "API handlers generated at $(GENERATED_DIR)/handlers.gen.go"

.PHONY: generate-api-handler install-oapi-codegen

