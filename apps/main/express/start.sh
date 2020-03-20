#!/bin/bash

set -euo pipefail

if [ "$NODE_ENV" == "production" ]
then
  INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/local-ipv4) node server
else
  node server
fi

