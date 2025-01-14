#!/bin/bash

# Stop on error
set -e

# Variables
IMAGE_NAME="runpod-pod-comfyui"
TAG="1.1.5"
DOCKER_HUB_USERNAME="alexgenovese"

# Ensure the script is run with the correct number of arguments
if [ "$#" -eq 2 ]; then
    IMAGE_NAME="$1"
    TAG="$2"
fi

# Check if already logged into Docker Hub
if docker info | grep -q "Username: $DOCKER_HUB_USERNAME"; then
    echo "Already logged into Docker Hub as $DOCKER_HUB_USERNAME."
else
    echo "Logging into Docker Hub..."
    docker login -u "$DOCKER_HUB_USERNAME"
fi

# Build the Docker image
echo "Building the Docker image: $IMAGE_NAME:$TAG"
docker build -t "$DOCKER_HUB_USERNAME/$IMAGE_NAME:$TAG" --platform linux/amd64 .

# Push the Docker image to Docker Hub
echo "Pushing the Docker image to Docker Hub"
docker push "$DOCKER_HUB_USERNAME/$IMAGE_NAME:$TAG"

echo "Docker image successfully built and pushed!"