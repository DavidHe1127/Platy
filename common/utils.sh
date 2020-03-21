#!/bin/bash

set -euo pipefail

function build_image() {
  APPLICATION_PATH=$1
  IMAGE=$2
  TAG=$3

  cd $APPLICATION_PATH/express && docker build -t "$IMAGE:$TAG" .
}

function tag_image() {
  IMAGE=$1
  TAG=$2
  REGISTRY=$3
  ECR_REPO=$4

  docker tag "$IMAGE:$TAG" "$REGISTRY/$ECR_REPO:$TAG"
}

function ecr_login() {
  eval "$(aws ecr get-login --no-include-email)"
}

function push_image() {
  REGISTRY=$1
  ECR_REPO=$2

  docker push "$REGISTRY/$ECR_REPO"
}

# Allows to call a function based on arguments passed to the script
$*
