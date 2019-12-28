#!/usr/bin/env bash

# Exit the script as soon as something fails.
set -e

task_definition="${1:-web}"
service_config="${2:-web}"
desired_count="${3:-2}"

# file include
source ./scripts/register-task-definition.sh

aws ecs update-service \
  --cluster "$CLUSTER" \
  --service "$service_config" \
  --task-definition "$task_definition" \
  --desired-count "$desired_count"
