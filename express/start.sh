#!/bin/bash

set -xe

if [ "$NODE_ENV" == "production" ]; then
  INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/public-hostname)
  node server
else
  node server
fi

