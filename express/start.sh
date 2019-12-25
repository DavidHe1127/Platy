#!bin/bash

set -xe

function let_us_do_it() {
  INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/public-hostname)
  node start.js
}

let_us_do_it
