#!/bin/bash


docker run --rm \
  -v "/Users/davidhe/.ssh:/root/.ssh:ro" \
  -e BUILDKITE_AGENT_TOKEN="2e7f35daff6531202185540f2f6d396486e1bcf34a4e6d429d" buildkite/agent
