#!/usr/bin/env bash

# Exit the script as soon as something fails.
set -e

# default to web if not provided
task_definition_name=${1:-web}
revision=${2:-1}

aws ecs deregister-task-definition --task-definition "$task_definition_name":"$revision"
