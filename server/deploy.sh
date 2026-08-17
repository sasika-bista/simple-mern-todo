#1/bin/bash
set -euo pipefail

USERNAME="sasikabista"
SERVER_IMAGE="mern-server-deploy"
CLIENT_IMAGE="mern-client-deploy"
TAG="v2"

SERVER_FULL_NAME="$USERNAME/$SERVER_IMAGE:$TAG"
SERVER_CONTAINER="mern-server-deploy"

CLIENT_FULL_NAME="$USERNAME/$CLIENT_IMAGE:$TAG"
CLIENT_CONTAINER="mern-client-deploy"
# --- connection details --
KEY="$HOME/mern-key.pem"
EC2_HOST="ec2-user@54.226.227.244"
echo "Deploying $SERVER_FULL_NAME to $EC2_HOST ..."

# run all the deploy commands ON the server, over SSH
ssh -o StrictHostKeyChecking=accept-new -i "$KEY" "$EC2_HOST" "
 docker pull $SERVER_FULL_NAME
 docker stop $SERVER_CONTAINER 2>/dev/null || true
 docker rm $SERVER_CONTAINER 2>/dev/null || true
 docker run -d --name $SERVER_CONTAINER \
 --restart always -p 5000:5000 $SERVER_FULL_NAME
"
echo "Deployed. App is live on port 5000."

echo "Deploying $CLIENT_FULL_NAME to $EC2_HOST ..."
# run all the deploy commands ON the server, over SSH
ssh -o StrictHostKeyChecking=accept-new -i "$KEY" "$EC2_HOST" "
 docker pull $CLIENT_FULL_NAME
 docker stop $CLIENT_CONTAINER 2>/dev/null || true
 docker rm $CLIENT_CONTAINER 2>/dev/null || true
 docker run -d --name $CLIENT_CONTAINER \
 --restart always -p 5173:5173 $CLIENT_FULL_NAME
"
echo "Deployed. App is live on port 5173."