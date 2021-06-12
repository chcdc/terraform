#!/bin/bash

BUCKET_NAME="secrets-aws"
OBJECT_NAME=$1
FILE_NAME="secrets/${OBJECT_NAME}"

aws s3 cp s3://${BUCKET_NAME}/${OBJECT_NAME} ${FILE_NAME}
chmod 400 ${FILE_NAME}

time terraform init -reconfigure -upgrade

time terraform ${@}