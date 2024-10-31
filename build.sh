#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function for logging into Docker Registry
docker_login() {
  if [ -z "$DOCKER_USERNAME" ] || [ -z "$DOCKER_PASSWORD" ]; then
    echo "DOCKER_USERNAME and DOCKER_PASSWORD environment variables must be set"
    exit 1
  fi

  echo "Logging in to Docker Registry..."
  echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin
  echo "Login successful"
}

# Check if already logged in to Docker Registry
if ! docker info | grep -q 'Username: '; then
  docker_login
fi

# Build and package spring-petclinic
echo "Building spring-petclinic..."
./gradlew build --no-daemon

# Build Docker image for spring-petclinic
echo "Building Docker image for spring-petclinic..."
docker build -t trukhinyuri/spring-petclinic:latest .

# Navigate to pingservice directory
cd ./pingservice

# Build and package pingservice
echo "Building pingservice..."
./gradlew build --no-daemon

# Build Docker image for pingservice
echo "Building Docker image for pingservice..."
docker build -t trukhinyuri/pingservice:latest .

# Push Docker images to registry
echo "Pushing Docker images to Registry..."
docker push trukhinyuri/spring-petclinic:latest
docker push trukhinyuri/pingservice:latest

echo "Build and push completed successfully."
