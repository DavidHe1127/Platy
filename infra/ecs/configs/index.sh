#!/bin/bash

set -euo pipefail

# redirect user data logging to instance console log
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

sudo curl -o /usr/local/bin/ecs-cli https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-linux-amd64-latest
sudo chmod +x /usr/local/bin/ecs-cli
ecs-cli --version

# install cfn boostrap script
sudo yum install -y aws-cfn-bootstrap

# use ECS_INSTANCE_ATTRIBUTES to set custom attributes which is used to
# help determine where to place your task
# only working on a unregistered instance
echo "ECS_INSTANCE_ATTRIBUTES=${attribute}" > /etc/ecs/ecs.config
echo "ECS_CLUSTER=${cluster}" >> /etc/ecs/ecs.config

echo "Signalling cfn to proceed `date +"%T"`"

/opt/aws/bin/cfn-signal \
  --exit-code $? \
  --stack "${stack}" \
  --resource "${resource}" \
  --region "ap-southeast-2"
