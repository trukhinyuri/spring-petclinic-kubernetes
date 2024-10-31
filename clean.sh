#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Print a message
echo "Cleaning build artifacts..."

# Clean build artifacts in the root directory
./gradlew clean --no-daemon

# Navigate to pingservice directory and clean build artifacts
cd ./pingservice
./gradlew clean --no-daemon

# Navigate back to the root directory
cd ..

# Remove Docker images
echo "Removing Docker images..."
docker rmi trukhinyuri/spring-petclinic:latest || true
docker rmi trukhinyuri/pingservice:latest || true

# Remove any intermediate build files and directories
echo "Removing intermediate build files..."
rm -rf build
rm -rf pingservice/build

echo "Clean up completed successfully."
