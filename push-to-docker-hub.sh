#!/bin/bash

# Optimized Docker Hub push script using build-optimized.sh
# Usage: ./push-to-docker-hub.sh [image-name] [tag]

# Stop on error
set -e

# Load environment variables from .env file
if [ -f .env ]; then
    echo "🔧 Caricamento variabili da .env..."
    # Enable automatic variable export
    set -o allexport
    source .env
    set +o allexport
    echo "✅ Variabili caricate: IMAGE_NAME=$IMAGE_NAME, TAG=$TAG"
else
    echo "⚠️  File .env non trovato, utilizzo valori di default"
fi

# Set default values if not defined in .env
IMAGE_NAME="${IMAGE_NAME:-runpod-comfyui}"
TAG="${TAG:-latest}"
DOCKER_HUB_USERNAME="${DOCKER_HUB_USERNAME:-}"
DOCKER_HUB_PASSWORD="${DOCKER_HUB_PASSWORD:-}"
HF_TOKEN="${HF_TOKEN:-}"

# Override with command line arguments if provided
if [ "$#" -eq 2 ]; then
    IMAGE_NAME="$1"
    TAG="$2"
    echo "📝 Parametri da linea di comando: IMAGE_NAME=$IMAGE_NAME, TAG=$TAG"
elif [ "$#" -eq 1 ]; then
    IMAGE_NAME="$1"
    echo "📝 Parametro da linea di comando: IMAGE_NAME=$IMAGE_NAME"
fi

# Validate required variables
if [ -z "$DOCKER_HUB_USERNAME" ]; then
    echo "❌ DOCKER_HUB_USERNAME non definito nel file .env"
    exit 1
fi

if [ -z "$DOCKER_HUB_PASSWORD" ]; then
    echo "❌ DOCKER_HUB_PASSWORD non definito nel file .env"
    exit 1
fi

echo "🚀 Inizio processo di build e push per $DOCKER_HUB_USERNAME/$IMAGE_NAME:$TAG"

# Check if already logged into Docker Hub
if docker info 2>/dev/null | grep -q "Username: $DOCKER_HUB_USERNAME"; then
    echo "✅ Già autenticato su Docker Hub come $DOCKER_HUB_USERNAME"
else
    echo "🔐 Autenticazione su Docker Hub..."
    echo "$DOCKER_HUB_PASSWORD" | docker login -u "$DOCKER_HUB_USERNAME" --password-stdin
fi

# Build the Docker image using the optimized build script
echo "🏗️  Building immagine Docker ottimizzata..."

# Export environment variables for the build script
export DOCKER_BUILDKIT=1
export BUILDKIT_PROGRESS=plain

# Create temporary build script args
BUILD_ARGS=""
if [ -n "$HF_TOKEN" ]; then
    BUILD_ARGS="--build-arg HUGGINGFACE_ACCESS_TOKEN=$HF_TOKEN"
fi

# Use the optimized build script approach but with our specific requirements
echo "📦 Costruzione immagine: $DOCKER_HUB_USERNAME/$IMAGE_NAME:$TAG"

docker build \
    --progress=plain \
    --build-arg BUILDKIT_INLINE_CACHE=1 \
    --build-arg CUDA_VERSION=12.8.1 \
    --build-arg UBUNTU_VERSION=22.04 \
    $BUILD_ARGS \
    --tag "$DOCKER_HUB_USERNAME/$IMAGE_NAME:$TAG" \
    --tag "$DOCKER_HUB_USERNAME/$IMAGE_NAME:latest" \
    --platform linux/amd64 \
    .

# Verify the build was successful
if [ $? -eq 0 ]; then
    echo "✅ Build completato con successo!"
else
    echo "❌ Build fallito!"
    exit 1
fi

# Run a quick health check before pushing
echo "🧪 Esecuzione health check rapido..."
if docker run --rm --gpus all "$DOCKER_HUB_USERNAME/$IMAGE_NAME:$TAG" /opt/venv/bin/python -c "import torch; print(f'PyTorch version: {torch.__version__}'); print(f'CUDA available: {torch.cuda.is_available()}')" 2>/dev/null; then
    echo "✅ Health check superato!"
else
    echo "⚠️  Health check fallito, ma procedo comunque con il push..."
fi

# Push the Docker image to Docker Hub
echo "📤 Push dell'immagine Docker su Docker Hub..."
docker push "$DOCKER_HUB_USERNAME/$IMAGE_NAME:$TAG"

# Also push the latest tag if we're not already using it
if [ "$TAG" != "latest" ]; then
    echo "📤 Push del tag 'latest'..."
    docker push "$DOCKER_HUB_USERNAME/$IMAGE_NAME:latest"
fi

echo "🎉 Immagine Docker creata e caricata con successo!"
echo "📋 Immagine disponibile come:"
echo "   - $DOCKER_HUB_USERNAME/$IMAGE_NAME:$TAG"
if [ "$TAG" != "latest" ]; then
    echo "   - $DOCKER_HUB_USERNAME/$IMAGE_NAME:latest"
fi

# Show image size
echo "📊 Dimensione immagine:"
docker images "$DOCKER_HUB_USERNAME/$IMAGE_NAME:$TAG" --format "table {{.Repository}}:{{.Tag}}\t{{.Size}}"