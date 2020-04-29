#!/bin/bash

OLD_AMI=ami-06862a6ef1260bb02
NEW_AMI=ami-064db566f79006111

# use ($string) to convert a string to array
# the outermost () construct the result into an array
INSTANCES=$(aws ecs list-attributes \
    --target-type container-instance \
    --attribute-name ecs.ami-id \
    --cluster dockerzon \
    --output json \
    --query 'attributes' \
    | jq -r -c --arg ami "$OLD_AMI" '[.[] | select(.value == $ami)]')

_jq() {
 echo $1 | base64 --decode | jq -r $2
}

for instance in $(jq -r '.[] | @base64' <<< "$INSTANCES"); do
   OLD_INSTANCE=$(_jq $instance '.targetId')
   echo $OLD_INSTANCE
   aws ecs list-tasks \
    --cluster dockerzon \
    --container-instance $OLD_INSTANCE \
    --desired-status RUNNING
done
