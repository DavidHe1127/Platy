import pulumi
from pulumi_aws import elasticsearch

policy = """
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::216659404274:root"
      },
      "Action": "es:*",
      "Resource": "arn:aws:es:ap-southeast-2:216659404274:domain/kinesis/*"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "es:*",
      "Resource": "arn:aws:es:ap-southeast-2:216659404274:domain/kinesis/*",
      "Condition": {
        "IpAddress": {
          "aws:SourceIp": "203.221.19.234"
        }
      }
    }
  ]
}
"""

example = elasticsearch.Domain('dockerzon-es',
                               cluster_config={
                                   'instance_type': 'm5.large.elasticsearch',
                                   'instance_count': 1,
                               },
                               elasticsearch_version='6.5',
                               ebs_options={
                                   'ebsEnabled': True,
                                   'volumeType': 'gp2',
                                   'volume_size': 10
                               },
                               access_policies=policy,
                               encrypt_at_rest={'enabled': True},
                               tags={
                                   'Domain': 'dockerzon-es',
                               })
