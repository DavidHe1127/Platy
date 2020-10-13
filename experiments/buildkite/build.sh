#!/bin/bash

docker build -t buildkite-custom \
  --build-arg SSH_KEY="$(cat $HOME/.ssh/id_rsa)" \
  .
