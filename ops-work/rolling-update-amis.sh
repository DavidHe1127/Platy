#!/bin/bash

set -euo pipefail

ASG_NAME=DockerzonClusterASG

# # Get latest AMI ID
AMI=$(aws ssm get-parameters \
  --names /aws/service/ecs/optimized-ami/amazon-linux-2/recommended \
  --region ap-southeast-2 \
  --output text \
  --query 'Parameters[0].Value' | jq -r '.image_id')

# Get current desired count
CURR_DESIRED_COUNT=$(aws autoscaling describe-auto-scaling-groups \
 --auto-scaling-group-name $ASG_NAME \
 --query "AutoScalingGroups[0].DesiredCapacity")

# Double up instances size
TEMP_DESIRED_COUNT=$(($CURR_DESIRED_COUNT * 2))

# set cwd
cd $(pwd)/../infra/asg

# plan
TF_PLAN=$(terraform plan --var-file="dev.tfvars" \
  -target="aws_autoscaling_group.dockerzon-cluster-asg" \
  -refresh=true\
  -out="tfplan" \
  -var "desired_capacity_asg=${TEMP_DESIRED_COUNT}"\
  --input=false)
