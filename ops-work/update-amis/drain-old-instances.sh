#!/bin/bash

# use ($string) to convert a string to array
INSTANCES=($(aws ecs list-container-instances \
  --cluster dockerzon \
  --query 'containerInstanceArns' \
  --output text \
  --status ACTIVE))

echo $INSTANCES

for instance in "${INSTANCES[@]}"
do
   echo $instance
   aws ecs list-tasks \
    --cluster dockerzon \
    --container-instance $instance \
    --desired-status RUNNING
done
