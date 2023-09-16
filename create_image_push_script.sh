#!/bin/bash

# Docker Hub credentials
DOCKER_USERNAME="ssumanish555@gmail.com"
DOCKER_PASSWORD="Docker@1234"

# Docker Hub repository and initial image name
REPO_NAME="sumanish/automated_bookmy_show_listing"
IMAGE_NAME="bookmy_show_listing"
TAG="v1"  # Initialize with the initial version

# Function to check the latest image version
check_latest_version() {
  # Pull the latest image from Docker Hub
  docker pull "$REPO_NAME:$TAG"

  # Check if the image exists locally
  if [ $? -eq 0 ]; then
    # Increment the version (e.g., v1, v2, v3, ...)
    TAG=$((TAG + 1))
  else
    # Exit the script if the image does not exist locally
    exit 0
  fi
}

# Check the latest version initially
check_latest_version

# Build and push the Docker image
# Stop the script after the first successful push and Docker Hub logout
# This will execute only once
# If you want to continue indefinitely, remove the while loop
# and the exit statement in check_latest_version
# and set a specific condition to stop the script
# after a certain number of iterations
# (e.g., after pushing a specific number of versions)
# or other criteria
# For example, you can set a counter and check if it reaches a certain limit

#done

# Log in to Docker Hub
docker login -u "$DOCKER_USERNAME" -p "$DOCKER_PASSWORD"

# Build the Docker image with the current version tag
docker build -t "$REPO_NAME:$TAG" -f ./feature/listing/Dockerfile ./feature/listing

# Push the image to Docker Hub
docker push "$REPO_NAME:$TAG"

# Log out of Docker Hub
docker logout

# Exit the script after the first successful push and Docker Hub logout
exit 0
