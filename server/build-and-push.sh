#!/bin/bash
set -euo pipefail
# --- settings (change USERNAME to your Docker Hub username) --
USERNAME="sasikabista"
SERVER_IMAGE="mern-server-deploy"
CLIENT_IMAGE="mern-client-deploy"
TAG="v1"

SERVER_FULL_NAME="$USERNAME/$SERVER_IMAGE:$TAG"
CLIENT_FULL_NAME="$USERNAME/$CLIENT_IMAGE:$TAG"

# --- 1. build the image from the Dockerfile here --
echo "Building $SERVER_FULL_NAME ..."
docker build -t "$SERVER_FULL_NAME" .
# --- 2. push it to Docker Hub --
echo "Pushing $SERVER_FULL_NAME ..."
docker push "$SERVER_FULL_NAME"
echo "Done. Image is live on Docker Hub."

# --- 1. build the image from the Dockerfile here --
echo "Building $CLIENT_FULL_NAME ..."
docker build -t "$CLIENT_FULL_NAME" ../client
# --- 2. push it to Docker Hub --
echo "Pushing $CLIENT_FULL_NAME ..."
docker push "$CLIENT_FULL_NAME"
echo "Done. Image is live on Docker Hub."