"""An AWS Python Pulumi program"""

import pulumi
import json

import data_stream
import elastic_search_domain

# Create an AWS resource (S3 Bucket)

# bucket = s3.Bucket('pulumi-quickstart',
#   website=s3.BucketWebsiteArgs(
#     index_document="index.html",
#   ))

# bucket_object = s3.BucketObject(
#   'index.html',
#   bucket=bucket,
#   acl='public-read',
#   content_type='text/html',
#   content=open('site/index.html').read()
# )

# # bucket_policy = s3.BucketPolicy("bucket-policy",
# #     bucket=bucket.id,
# #     policy=public_read_policy_for_bucket(bucket.id)
# # )

# # Export values if you wish to access outside your app via
# pulumi stack output

# pulumi.export('bucket_name', bucket.id)
# pulumi.export('bucket_endpoint', pulumi.Output.concat('http://', bucket.website_endpoint))
