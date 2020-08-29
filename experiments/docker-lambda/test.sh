#!/bin/sh

AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id --profile qq)
AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key --profile qq)

event=$(cat ./sample_event.json)

docker run --rm \
  -v "$PWD":/var/task:ro,delegated \
  -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
  -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
  lambci/lambda:python3.8 \
  index.lambda_handler \
  "${event}"
