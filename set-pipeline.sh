#! /bin/bash

if [ $# -lt 2 ]; then
	echo "$0 <deploy_env> <pipeline>"
	exit 1
fi

DEPLOY_ENV=$1; shift
PIPELINE_YML=$1; shift


PIPELINE_NAME=${PIPELINE_YML%%.yml}
PIPELINE_NAME=${PIPELINE_NAME##*/}
./fly set-pipeline -c $PIPELINE_YML \
    --var "deploy_env=$DEPLOY_ENV" \
    --var "bucket_name=${DEPLOY_ENV}-tfstate" \
    --var "aws_access_key_id=$AWS_ACCESS_KEY_ID" \
    --var "aws_secret_access_key=$AWS_SECRET_ACCESS_KEY" \
    -p $PIPELINE_NAME -n

./fly unpause-pipeline -p $PIPELINE_NAME

