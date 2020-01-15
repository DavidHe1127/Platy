#!/bin/bash

aws cloudformation create-stack \
    --stack-name custom-ami \
    --template-body file://main.yaml \
    --parameters file://params.json
