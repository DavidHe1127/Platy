#!/bin/bash

aws cloudformation delete-stack \
    --stack-name custom-ami

if [ $? -eq 0 ]
  then
    echo "operation was successful"
else
  echo "operation failed"
fi
