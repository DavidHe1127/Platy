import pulumi
from pulumi_aws import kinesis

test_stream = kinesis.Stream('testStream', shard_count=2)
