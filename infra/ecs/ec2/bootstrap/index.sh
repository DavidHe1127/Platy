#!/bin/bash

set -euo pipefail

source ./install-ecs-cli.sh

echo "ECS_CLUSTER=${cluster}" > /etc/ecs/ecs.config
