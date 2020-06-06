#!/bin/bash

set -euo pipefail

ASG_NAME=DockerzonClusterASG
MAX_SIZE_ASG=4

# Get latest AMI ID
LATEST_AMI=$(aws ssm get-parameters \
  --names /aws/service/ecs/optimized-ami/amazon-linux-2/recommended \
  --region ap-southeast-2 \
  --output text \
  --query 'Parameters[0].Value' | jq -r '.image_id')

# get current desired count
CURR_DESIRED_COUNT=$(aws autoscaling describe-auto-scaling-groups \
 --auto-scaling-group-name $ASG_NAME \
 --query "AutoScalingGroups[0].DesiredCapacity")

# double up instances size
TEMP_DESIRED_COUNT=$(($CURR_DESIRED_COUNT * 2))

# set cwd
cd $(pwd)/../../infra/asg

# plan
terraform plan \
  --var-file="dev.tfvars" \
  -target="aws_cloudformation_stack.dockerzon-cluster-asg" \
  -refresh=true\
  -out="tfplan" \
  -var "desired_capacity_asg=${TEMP_DESIRED_COUNT}" \
  -var "max_size_asg=${MAX_SIZE_ASG}" \
  -var "ami=${LATEST_AMI}" \
  --input=false \
  > /dev/null 2>&1

# print changes
CHANGES=$(terraform show -json tfplan | jq '.resource_changes[].change')

# turn off immediate exit upon non-zero exit code as we don't want to exit when 1 is returned by diff
# Diff returns this exit code when difference has been found
set +e

diff -u \
  <(echo "$CHANGES" | jq '.before') \
  <(echo "$CHANGES" | jq '.after')

# apply changes...
terraform apply \
  -input=false \
  tfplan
