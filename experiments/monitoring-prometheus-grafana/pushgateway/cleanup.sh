#!/bin/bash

num_files=$(rm -vrif /etc/debug_data/* | wc -l)

cat << EOF | curl --data-binary @- http://localhost:9091/metrics/job/debug_cleanup/instance/192.168.86.90
  # TYPE job_executed_successful gauge
  job_executed_successful 1
EOF
