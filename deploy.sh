#!/bin/bash

# Complete deployment script - builds and pushes to Docker Hub
# Usage: ./deploy.sh [image-name] [tag]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
log_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

log_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

log_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Load environment variables from .env file
if [ -f .env ]; then
    log_info "Caricamento variabili da .env..."
    set -o allexport
    source .env
    set +o allexport
    log_success "Variabili caricate"
else
    log_warning "File .env non trovato"
fi

# Set defaults
IMAGE_NAME="${IMAGE_NAME:-runpod-comfyui}"
TAG="${TAG:-latest}"
DOCKER_HUB_USERNAME="${DOCKER_HUB_USERNAME:-}"

# Override with command line arguments
if [ "$#" -eq 2 ]; then
    IMAGE_NAME="$1"
    TAG="$2"
elif [ "$#" -eq 1 ]; then
    IMAGE_NAME="$1"
fi

# Validate
if [ -z "$DOCKER_HUB_USERNAME" ]; then
    log_error "DOCKER_HUB_USERNAME non definito"
    exit 1
fi

log_info "🚀 Deployment di $DOCKER_HUB_USERNAME/$IMAGE_NAME:$TAG"

# Step 1: Build with optimized script
log_info "📦 Fase 1: Build dell'immagine..."
./build-optimized.sh "$IMAGE_NAME"

if [ $? -eq 0 ]; then
    log_success "Build completato"
else
    log_error "Build fallito"
    exit 1
fi

# Step 2: Tag for Docker Hub
log_info "🏷️  Fase 2: Tagging per Docker Hub..."
docker tag "$IMAGE_NAME:latest" "$DOCKER_HUB_USERNAME/$IMAGE_NAME:$TAG"
docker tag "$IMAGE_NAME:latest" "$DOCKER_HUB_USERNAME/$IMAGE_NAME:latest"
log_success "Tagging completato"

# Step 3: Push to Docker Hub
log_info "📤 Fase 3: Push su Docker Hub..."
./push-to-docker-hub.sh "$IMAGE_NAME" "$TAG"

if [ $? -eq 0 ]; then
    log_success "Deployment completato con successo!"
    echo ""
    log_info "📋 Riepilogo:"
    echo "   🏷️  Immagine: $DOCKER_HUB_USERNAME/$IMAGE_NAME:$TAG"
    echo "   🏷️  Latest: $DOCKER_HUB_USERNAME/$IMAGE_NAME:latest"
    echo "   🌐 Pull: docker pull $DOCKER_HUB_USERNAME/$IMAGE_NAME:$TAG"
else
    log_error "Push fallito"
    exit 1
fi
