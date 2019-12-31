#!/usr/bin/env bash

# Exit the script as soon as something fails.
set -e

task_definition="${1:-web}"

aws ecs register-task-definition \
  --cli-input-json file://"$APPLICATION_PATH"/ecs/"$task_definition"-task-definition.json \
  --tags key=datetime,value="$(date +%Y-%m-%d\ %H:%M:%S)"
