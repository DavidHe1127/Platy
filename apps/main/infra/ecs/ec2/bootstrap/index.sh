#!/bin/bash

source ./install-ecs-cli.sh

echo "ECS_CLUSTER=${cluster}" > /etc/ecs/ecs.config

# use ECS_INSTANCE_ATTRIBUTES to set custom attributes which is used to
# help determine where to place your task
# only working on a unregistered instance
# echo ECS_INSTANCE_ATTRIBUTES='{"location": "instanceTwo"}' >> /etc/ecs/ecs.config
