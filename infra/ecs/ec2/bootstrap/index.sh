#!/bin/bash

sudo curl -o /usr/local/bin/ecs-cli https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-linux-amd64-latest
sudo chmod +x /usr/local/bin/ecs-cli
ecs-cli --version

# use ECS_INSTANCE_ATTRIBUTES to set custom attributes which is used to
# help determine where to place your task
# only working on a unregistered instance
echo "ECS_INSTANCE_ATTRIBUTES=${attribute}" > /etc/ecs/ecs.config
echo "ECS_CLUSTER=${cluster}" >> /etc/ecs/ecs.config
