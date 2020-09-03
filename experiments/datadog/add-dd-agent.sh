#!/bin/sh

path=$(pwd)
task=datadog-agent-task

# # a task to run dd agent container
revision=$(aws ecs register-task-definition \
  --cli-input-json file://$path/dd-agent-task-def.json \
  --query 'taskDefinition.revision')

# run task as a DAEMON service which deploys exactly one task on each container instance
aws ecs create-service \
    --cluster dockerzon \
    --service-name dd-agent \
    --task-definition datadog-agent-task:$revision \
    --scheduling-strategy DAEMON
