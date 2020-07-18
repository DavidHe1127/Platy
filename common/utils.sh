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

  DESIRED_TASK_COUNT=$6
  VPC_ID=$7
  export TASK_EXEC_ROLE_ARN=$8

  TARGET_GROUP_ARN=$(aws elbv2 describe-target-groups \
                    --name $TARGET_GROUP_NAME \
                    --query 'TargetGroups[0].{arn:TargetGroupArn}.arn' \
                    --output text)

  SERVICE=$(aws ecs describe-services \
        --services $APPLICATION_NAME \
        --cluster dockerzon \
        --output json | jq -r '.services' | jq length)

  if [ -z "$SERVICE" ];then
    echo 'Service not found... Deploying service with Service Discovery'
    # spin up service with count set to 1
    ecs-cli compose \
      --file ./docker-compose.yml \
      --project-name $APPLICATION_NAME \
      --ecs-params ./ecs-params.yml \
      --region ap-southeast-2 \
      --cluster $CLUSTER \
      service up \
      --timeout 8 \
      --launch-type EC2 \
      --create-log-groups \
      --target-group-arn $TARGET_GROUP_ARN \
      --container-name $CONTAINER_NAME \
      --container-port $CONTAINER_PORT \
      --vpc $VPC_ID \
      --health-check-grace-period 300 \
      --enable-service-discovery \
      --sd-container-name $CONTAINER_NAME \
      --sd-container-port $CONTAINER_PORT \
      --private-dns-namespace dockerzon-dns-ns \
      --dns-ttl 300 \
      --dns-type SRV
  else
    echo 'Service found... Deploying service without Service Discovery'
    # spin up service with count set to 1
    ecs-cli compose \
      --file ./docker-compose.yml \
      --project-name $APPLICATION_NAME \
      --ecs-params ./ecs-params.yml \
      --region ap-southeast-2 \
      --cluster $CLUSTER \
      service up \
      --timeout 8 \
      --launch-type EC2 \
      --create-log-groups \
      --target-group-arn $TARGET_GROUP_ARN \
      --container-name $CONTAINER_NAME \
      --container-port $CONTAINER_PORT \
      --vpc $VPC_ID \
      --health-check-grace-period 300
  fi

  # scale it up to desired task count
  ecs-cli compose \
    --file ./docker-compose.yml \
    --project-name $APPLICATION_NAME \
    --ecs-params ./ecs-params.yml \
    --region ap-southeast-2 \
    --cluster $CLUSTER \
    service scale $DESIRED_TASK_COUNT \
    --deployment-max-percent 200 \
    --deployment-min-healthy-percent 100 \
    --timeout 8
}

function enable_service_auto_scaling() {
  CLUSTER=$1
  APPLICATION_NAME=$2
  MIN_TASK_COUNT=$3
  MAX_TASK_COUNT=$4

  # If the service supports service-linked roles,
  # Application Auto Scaling uses a service-linked role,
  # which it creates if it does not yet exist
  aws application-autoscaling register-scalable-target \
    --service-namespace ecs \
    --scalable-dimension ecs:service:DesiredCount \
    --resource-id "service/${CLUSTER}/${APPLICATION_NAME}" \
    --min-capacity $MIN_TASK_COUNT \
    --max-capacity $MAX_TASK_COUNT

  aws application-autoscaling put-scaling-policy \
    --service-namespace ecs \
    --scalable-dimension ecs:service:DesiredCount \
    --resource-id "service/${CLUSTER}/${APPLICATION_NAME}" \
    --policy-name "cpu75-${APPLICATION_NAME}-auto-scaling-policy" \
    --policy-type TargetTrackingScaling \
    --target-tracking-scaling-policy-configuration file://service_auto_scaling_config.json
}

# Allows to call a function based on arguments passed to the script
$*
