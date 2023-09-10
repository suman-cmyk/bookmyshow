# # Stage 1: Build the Go application
# FROM golang:latest AS builder

# # Set CGO_ENABLED=0 to build a statically linked binary
# ENV CGO_ENABLED=0

# WORKDIR /app

# # Copy only the Go module files and download the dependencies first to leverage Docker layer caching
# COPY go.mod go.sum ./
# RUN go mod download

# # Copy the rest of the application source code
# COPY . .

# # Build the Go application into a binary
# RUN go build -o /book_anish_show ./cmd/main.go

# # Stage 2: Create the final lightweight image
# FROM alpine:latest

# WORKDIR /app

# # Copy the binary from the builder stage
# COPY --from=builder /book_anish_show ./

# # Expose the port your application will listen on
# EXPOSE 8080

# # Command to run your Go application
# CMD ["./book_anish_show"]

# # /
# # └── app
# #     ├── book_anish_show (binary)
# #     └── Dockerfile (only exists temporarily during the build)

#######################################################################################

# Use the official Go image as the base image
FROM golang:latest

# Set the working directory inside the container
WORKDIR /app

# # Copy the Go module files into the container
# COPY go.mod go.sum ./

# # Download Go dependencies
# RUN go mod download

# # Install oapi-codegen
# RUN go get github.com/deepmap/oapi-codegen/cmd/oapi-codegen

# Copy the entire application source code into the container
COPY . .

# Print the contents of the current directory for debugging purposes
RUN ls -al

# Build the Go application into a binary
# RUN go build -o ./book_anish_show ./cmd/main.go

# Expose the port your application will listen on
EXPOSE 8080

# Command to run your Go application
# CMD ["./book_anish_show"]

CMD ["go", "run", "/app/cmd/main.go"]

