#!/usr/bin/env bash

# set -euo pipefail

PLACEHOLDER_BACKEND_NAME="express"
PLACEHOLDER_BACKEND_PORT="8000"

if [ "$NODE_NEV" == "production" ]
then
  PLACEHOLDER_VHOST="$(curl http://169.254.169.254/latest/meta-data/local-ipv4)"
else
  PLACEHOLDER_VHOST="localhost"
fi

# Where is our default config located?
DEFAULT_CONFIG_PATH="/etc/nginx/conf.d/default.conf"

# Replace all instances of the placeholders with the values above.
sed -i "s/PLACEHOLDER_VHOST/${PLACEHOLDER_VHOST}/g" "${DEFAULT_CONFIG_PATH}"
sed -i "s/PLACEHOLDER_BACKEND_NAME/${PLACEHOLDER_BACKEND_NAME}/g" "${DEFAULT_CONFIG_PATH}"
sed -i "s/PLACEHOLDER_BACKEND_PORT/${PLACEHOLDER_BACKEND_PORT}/g" "${DEFAULT_CONFIG_PATH}"

# Execute the CMD from the Dockerfile and pass in all of its arguments.
exec "$@"
