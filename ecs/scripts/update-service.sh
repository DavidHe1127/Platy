#!/usr/bin/env bash

# Exit the script as soon as something fails.
set -e

task_definition="${1:-web}"
service_config="${2:-web}"
desired_count="${3:-2}"

# file include
source ./scripts/register-task-definition.sh "$task_definition"

# --task-definition (string)
# The family and revision (family:revision ) or full ARN of the task definition to run in your
# service. If a revision is not specified, the latest ACTIVE revision is used.
# If you modify the task definition with UpdateService ,
# Amazon ECS spawns a task with the new version
# of the task definition and then stops an old task after the new version is running.
aws ecs update-service \
  --cluster "$CLUSTER" \
  --service "$service_config" \
  --task-definition "$task_definition" \
  --desired-count "$desired_count"
