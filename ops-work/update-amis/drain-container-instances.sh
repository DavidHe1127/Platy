#!/bin/bash

INSTANCES_ID=$(aws autoscaling describe-auto-scaling-groups \
  --auto-scaling-group-name DockerzonClusterASG \
  --query "AutoScalingGroups[].Instances[]" \
  --output json | jq -r -c '[.[] | select(.LifecycleState == "InService") | .InstanceId]' | sed "s/\"/'/g")

CONTAINERS_ARN=$(aws ecs list-container-instances \
  --cluster dockerzon \
  --filter "ec2InstanceId in ${INSTANCES_ID}" \
  --query "containerInstanceArns" | jq -r -c 'join(" ")')

aws ecs update-container-instances-state \
  --cluster dockerzon \
  --container-instances $CONTAINERS_ARN \
  --status DRAINING
