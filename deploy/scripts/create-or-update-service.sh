#!/usr/bin/env bash

set -euo pipefail

# spin up service with count set to 1
ecs-cli compose \
  --file ./docker-compose.yml \
  --project-name ${APPLICATION_NAME} \
  --ecs-params ./ecs-params.yml \
  --region ap-southeast-2 \
  --cluster ${CLUSTER} \
  service up \
  --timeout 8 \
  --create-log-groups \
  --target-group-arn ${TARGET_GROUP_ARN} \
  --container-name ${CONTAINER_NAME} \
  --container-port ${CONTAINER_PORT} \
  --role ${SERVICE_ROLE_ARN}

# scale it up to desired task count
ecs-cli compose \
  --file ./docker-compose.yml \
  --project-name ${APPLICATION_NAME} \
  --ecs-params ./ecs-params.yml \
  --region ap-southeast-2 \
  --cluster ${CLUSTER} \
  service scale ${DESIRED_TASK_COUNT} \
  --deployment-max-percent 100 \
  --deployment-min-healthy-percent 50 \
  --timeout 8
