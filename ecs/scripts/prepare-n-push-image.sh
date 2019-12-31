#!/usr/bin/env bash

# Exit the script as soon as something fails.
set -e

cd "${APPLICATION_PATH}" && docker-compose build

docker tag "$DOCKERZON_IMAGE:$BUILD" "$REGISTRY/$DOCKERZON_REPO:$BUILD"
docker tag "$NGINX_IMAGE:$BUILD" "$REGISTRY/$NGINX_REPO:$BUILD"

eval "$(aws ecr get-login --no-include-email)"

docker push "$REGISTRY/$DOCKERZON_REPO"
docker push "$REGISTRY/$NGINX_REPO"
