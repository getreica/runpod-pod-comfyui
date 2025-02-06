#!/bin/bash

# Stop on error
set -e


# Se esiste un file .env, carica le variabili in esso definite
if [ -f .env ]; then
    echo "Caricamento variabili da .env..."
    # Abilita l'esportazione automatica delle variabili
    set -o allexport
    source .env
    set +o allexport
fi

# Se una variabile non è stata definita (in .env o altrove) la impostiamo a stringa vuota
IMAGE_NAME="${IMAGE_NAME:-}"
TAG="${TAG:-}"
DOCKER_HUB_USERNAME="${DOCKER_HUB_USERNAME:-}"
HF_TOKEN="${HF_TOKEN:-}"

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
    docker login -u "$DOCKER_HUB_USERNAME" -p "$DOCKER_HUB_PASSWORD"
fi

# Build the Docker image
echo "Building the Docker image: $IMAGE_NAME:$TAG"
docker build --build-arg HUGGINGFACE_ACCESS_TOKEN=$HF_TOKEN -t "$DOCKER_HUB_USERNAME/$IMAGE_NAME:$TAG" --platform linux/amd64 .

# Push the Docker image to Docker Hub
echo "Pushing the Docker image to Docker Hub"
docker push "$DOCKER_HUB_USERNAME/$IMAGE_NAME:$TAG"

echo "Docker image successfully built and pushed!"