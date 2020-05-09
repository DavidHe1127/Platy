#!/bin/bash

BUCKET_NAME=dave-dockerzon-ecs-tfstate
REGION=$(aws configure get region)

IF_EXIST=$(aws s3 ls --human-readable | grep $BUCKET_NAME)

if [[ -z ${IF_EXIST} ]]
  then
    # create bucket
    aws s3api create-bucket \
      --bucket $BUCKET_NAME \
      --region $REGION \
      --create-bucket-configuration LocationConstraint=$REGION
fi

# enable versioning
aws s3api put-bucket-versioning \
  --bucket $BUCKET_NAME \
  --versioning-configuration 'Status=Enabled'

# create policy
cat <<EOF > policy.json
{
  "Id": "DockerzonPolicyId19851111",
  "Statement": [
    {
      "Sid": "DockerzonStmtSid19851111",
      "Action": [
        "s3:DeleteBucket"
      ],
      "Effect": "Deny",
      "Resource": "arn:aws:s3:::${BUCKET_NAME}",
      "Principal": {
        "AWS": [
          "*"
        ]
      }
    }
  ]
}
EOF

aws s3api put-bucket-policy \
  --bucket $BUCKET_NAME \
  --policy 'file://policy.json'

rm -rf policy.json

if [ $? -eq 0 ]
  then
    echo "Bucket created/updated correctly"
  else
    echo "Bucket operation failed"
fi
