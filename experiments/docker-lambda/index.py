import boto3
import json
import os
import subprocess

def lambda_handler(event, context):
  s3_client = boto3.client('s3')
  res = s3_client.list_buckets()

  bucket = event['Records'][0]['s3']['bucket']['name']
  key = 'jenkins-init-scripts/Jenkinsfile'

  response = s3_client.get_object(Bucket=bucket, Key=key)

  print(response['Body'].read(), type(response['Body']))

  return {
    'statusCode': 200,
    'body': json.dumps('Hello from Lambda!')
  }

