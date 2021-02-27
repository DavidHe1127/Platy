#!/bin/bash

docker run \
 -p 9091:9090 \
 -v "${PWD}/prometheus.yml:/etc/prometheus/prometheus.yml" \
 prom/prometheus

