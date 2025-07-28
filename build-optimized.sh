#!/bin/bash

# Optimized Docker build script with BuildKit
# Usage: ./build-optimized.sh [tag-name]

set -e

# Load environment variables from .env file
if [ -f .env ]; then
    echo "🔧 Caricamento variabili da .env..."
    set -o allexport
    source .env
    set +o allexport
fi

# Set default values
DEFAULT_TAG_NAME="${IMAGE_NAME:-runpod-comfyui}"
TAG_NAME=${1:-$DEFAULT_TAG_NAME}

echo "🚀 Building optimized Docker image: $TAG_NAME"
echo "📋 Using BuildKit for enhanced caching and performance"

# Enable BuildKit for better performance and caching
export DOCKER_BUILDKIT=1

# Prepare build arguments
BUILD_ARGS=""
if [ -n "$HF_TOKEN" ]; then
    BUILD_ARGS="--build-arg HUGGINGFACE_ACCESS_TOKEN=$HF_TOKEN"
    echo "🔑 Hugging Face token configurato"
fi

# Build with optimized flags
docker build \
    --progress=plain \
    --build-arg BUILDKIT_INLINE_CACHE=1 \
    --build-arg CUDA_VERSION=12.8.1 \
    --build-arg UBUNTU_VERSION=22.04 \
    $BUILD_ARGS \
    --tag "$TAG_NAME:latest" \
    --tag "$TAG_NAME:$(date +%Y%m%d)" \
    --platform linux/amd64 \
    .

echo "✅ Build completed successfully!"
echo "📦 Image tagged as: $TAG_NAME:latest and $TAG_NAME:$(date +%Y%m%d)"

# Optional: Run a quick test
echo "🧪 Running quick health check..."
if docker run --rm --gpus all "$TAG_NAME:latest" /opt/venv/bin/python -c "import torch; print(f'PyTorch version: {torch.__version__}'); print(f'CUDA available: {torch.cuda.is_available()}')"; then
    echo "✅ Health check passed!"
else
    echo "❌ Health check failed!"
    exit 1
fi
