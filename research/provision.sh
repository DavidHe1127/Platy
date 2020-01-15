#!/bin/bash

aws cloudformation create-stack \
    --stack-name basic-ec2 \
    --template-body file://ec2.yaml \
    --parameters file://params.json
