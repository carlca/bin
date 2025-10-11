#!/bin/zsh

# Remove the previous image from Docker
IMAGE_ID=$(docker images -q magic-image)

if [ -n "$IMAGE_ID" ]; then
  echo "Found 'magic-image' with ID: $IMAGE_ID"
  # Remove the image forcefully
  docker image rm -f "$IMAGE_ID"
fi

# Build the new Docker image
docker build --no-cache --platform linux/amd64 -t magic-image -f magic-docker/Dockerfile .

# Tag the image for pushing to GitHub Container Registry
docker tag magic-image ghcr.io/carlca/magic-image:latest

# Push the image to GitHub Container Registry
docker push ghcr.io/carlca/magic-image:latest
