#!/bin/bash

aws iam create-role \
  --role-name packer-builder-role \
  --assume-role-policy-document file://role-assumer.json

aws iam put-role-policy \
  --role-name packer-builder-role \
  --policy-name packer-builder-role-policy \
  --policy-document file://policy.json

aws iam create-instance-profile \
  --instance-profile-name packer-builder-instance-profile

aws iam add-role-to-instance-profile \
  --instance-profile-name packer-builder-instance-profile \
  --role-name packer-builder-role
