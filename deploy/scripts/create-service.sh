#!/usr/bin/env bash

# Exit the script as soon as something fails.
set -e

service_config="${1:-web}"

aws ecs create-service \
  --cli-input-json file://"$APPLICATION_PATH"/ecs/"$service_config"-service.json
