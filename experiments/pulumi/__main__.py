"""An AWS Python Pulumi program"""

import pulumi
import json

from pulumi_aws import s3

# def public_read_policy_for_bucket(bucket_id):
#   return json.dumps({
#       "Version": "2012-10-17",
#       "Statement": [{
#           "Effect": "Allow",
#           "Principal": "*",
#           "Action": [
#               "s3:GetObject"
#           ],
#           "Resource": [
#               f"arn:aws:s3:::{bucket_id}/*",
#           ]
#       }]
#   })

# Create an AWS resource (S3 Bucket)
bucket = s3.Bucket('pulumi-quickstart',
  website=s3.BucketWebsiteArgs(
    index_document="index.html",
  ))

bucket_object = s3.BucketObject(
  'index.html',
  bucket=bucket,
  acl='public-read',
  content_type='text/html',
  content=open('site/index.html').read()
)

# bucket_policy = s3.BucketPolicy("bucket-policy",
#     bucket=bucket.id,
#     policy=public_read_policy_for_bucket(bucket.id)
# )

# Export the name of the bucket
pulumi.export('bucket_name', bucket.id)
pulumi.export('bucket_endpoint', pulumi.Output.concat('http://', bucket.website_endpoint))
