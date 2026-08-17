# #!/bin/bash
# set -euo pipefail
# # --- settings (change USERNAME to your Docker Hub username) --
# USERNAME="sasikabista"
# SERVER_IMAGE="mern-server-deploy"
# CLIENT_IMAGE="mern-client-deploy"
# TAG="v1"

# SERVER_FULL_NAME="$USERNAME/$SERVER_IMAGE:$TAG"
# CLIENT_FULL_NAME="$USERNAME/$CLIENT_IMAGE:$TAG"

# # --- 1. build the image from the Dockerfile here --
# echo "Building $SERVER_FULL_NAME ..."
# docker build -t "$SERVER_FULL_NAME" .
# # --- 2. push it to Docker Hub --
# echo "Pushing $SERVER_FULL_NAME ..."
# docker push "$SERVER_FULL_NAME"
# echo "Done. Image is live on Docker Hub."

# # --- 1. build the image from the Dockerfile here --
# echo "Building $CLIENT_FULL_NAME ..."
# docker build -t "$CLIENT_FULL_NAME" ../client
# # --- 2. push it to Docker Hub --
# echo "Pushing $CLIENT_FULL_NAME ..."
# docker push "$CLIENT_FULL_NAME"
# echo "Done. Image is live on Docker Hub."

#!/bin/bash
set -euo pipefail
# settings arrive from the environment (the workflow provides them)
FULL_NAME="$DOCKERHUB_USERNAME/$IMAGE:latest"
# log in without a prompt, using the token piped in
echo "$DOCKERHUB_TOKEN" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin
echo "Building $FULL_NAME from $CONTEXT ..."
docker build -t "$FULL_NAME" "$CONTEXT"
echo "Pushing $FULL_NAME ..."
docker push "$FULL_NAME"
echo "Done. Image is live on Docker Hub."
