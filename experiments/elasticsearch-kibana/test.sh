#!/bin/bash

curl 'http://localhost:9200/_cluster/health?level=indices' | jq . > output.json

# curl -X DELETE 'http://localhost:9200/kibana_sample_data_ecommerce' | jq . > output.json
