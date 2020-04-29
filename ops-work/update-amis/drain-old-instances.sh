#!/bin/bash

set -uo pipefail

# CORRECT
OLD_AMI=ami-06862a6ef1260bb02
NEW_AMI=ami-064db566f79006111

# WRONG for testing purpose
# OLD_AMI=ami-064db566f79006111
# NEW_AMI=ami-06862a6ef1260bb02

function _jq() {
  echo $1 | base64 --decode | jq -r $2
}

function has_running_tasks() {
  for instance in $(jq -r '.[] | @base64' <<< "$INSTANCES"); do
     OLD_INSTANCE=$(_jq $instance '.targetId')
     RUNNING_TASK_COUNT=$(aws ecs list-tasks \
      --cluster dockerzon \
      --container-instance $OLD_INSTANCE \
      --desired-status RUNNING \
      --query 'length(taskArns)')

      if [ $RUNNING_TASK_COUNT -ne 0 ];then
        return 0
      fi
  done

  return 1
}

# Entry Point

# list instances on old amis
INSTANCES=$(aws ecs list-attributes \
    --target-type container-instance \
    --attribute-name ecs.ami-id \
    --cluster dockerzon \
    --output json \
    --query 'attributes' \
    | jq -r -c --arg ami "$OLD_AMI" '[.[] | select(.value == $ami)]')

# instances found
if [ $(jq 'length' <<< $INSTANCES) -ne 0 ]
  then
    echo "Some instances are on old amis... let's update them!"
    aws ecs update-container-instances-state \
      --cluster dockerzon \
      --container-instances 'arn:aws:ecs:ap-southeast-2:216659404274:container-instance/22332b76-89f9-44cd-89ef-1d9eafe9d280' \
      --status DRAINING
fi

# give 5 mins of time as check grace period
sleep 300s

# check if old instances still have running tasks
has_running_tasks

RTN=$?
COUNT=0

echo $RTN

while [ $RTN == 1 ]; do
  echo 'not 0 sleep for 10s...'
  sleep 10s
  echo 'check again...'
  COUNT=$(($COUNT + 1))
  has_running_tasks
  RTN=$?

  if [ $COUNT -eq 100 ]
    then
      RTN=0
      echo "timeout elapsed... let's get out of there!"
  fi

done

echo "All tasks have been moved onto new instances!"
