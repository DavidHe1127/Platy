#!/bin/bash

set -euo pipefail

function build_image() {
  APPLICATION_PATH=$1
  IMAGE=$2
  TAG=$3

  cd $APPLICATION_PATH && docker build -t "$IMAGE:$TAG" .
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

function deploy_service() {
  APPLICATION_NAME=$1
  CLUSTER=$2
  TARGET_GROUP_NAME=$3

  CONTAINER_NAME=$4
  CONTAINER_PORT=$5

  SERVICE_ROLE_ARN=$6
  DESIRED_TASK_COUNT=$7

  TARGET_GROUP_ARN=$(aws elbv2 describe-target-groups \
                    --name $TARGET_GROUP_NAME \
                    --query 'TargetGroups[0].{arn:TargetGroupArn}.arn' \
                    --output text)

  # spin up service with count set to 1
  ecs-cli compose \
    --file ./docker-compose.yml \
    --project-name $APPLICATION_NAME \
    --ecs-params ./ecs-params.yml \
    --region ap-southeast-2 \
    --cluster $CLUSTER \
    service up \
    --timeout 8 \
    --create-log-groups \
    --target-group-arn $TARGET_GROUP_ARN \
    --container-name $CONTAINER_NAME \
    --container-port $CONTAINER_PORT \
    --role $SERVICE_ROLE_ARN

  # scale it up to desired task count
  ecs-cli compose \
    --file ./docker-compose.yml \
    --project-name $APPLICATION_NAME \
    --ecs-params ./ecs-params.yml \
    --region ap-southeast-2 \
    --cluster $CLUSTER \
    service scale $DESIRED_TASK_COUNT \
    --deployment-max-percent 100 \
    --deployment-min-healthy-percent 0 \
    --timeout 8
}

# Allows to call a function based on arguments passed to the script
$*
