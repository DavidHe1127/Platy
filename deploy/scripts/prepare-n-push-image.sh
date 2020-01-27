#!/usr/bin/env bash

# Exit the script as soon as something fails.
set -e

cd "${APPLICATION_PATH}" && docker-compose build

docker tag "$EXPRESS_IMAGE:$BUILD" "$REGISTRY/$EXPRESS_REPO:$BUILD"
docker tag "$NGINX_IMAGE:$BUILD" "$REGISTRY/$NGINX_REPO:$BUILD"

eval "$(aws ecr get-login --no-include-email)"

docker push "$REGISTRY/$EXPRESS_REPO"
docker push "$REGISTRY/$NGINX_REPO"
