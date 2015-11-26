#! /bin/bash

if [ $# -lt 2 ]; then
	echo "$0 <deploy_env> <pipeline>"
	exit 1
fi

# Find fly binary
[ -x ./fly ] && fly=./fly || fly=fly


DEPLOY_ENV=$1; shift
PIPELINE_YML=$1; shift


PIPELINE_NAME=${PIPELINE_YML%%.yml}
PIPELINE_NAME=${PIPELINE_NAME##*/}
$fly set-pipeline -c $PIPELINE_YML \
    --var "deploy_env=$DEPLOY_ENV" \
    --var "bucket_name=${DEPLOY_ENV}-tfstate" \
    --var "aws_access_key_id=$AWS_ACCESS_KEY_ID" \
    --var "aws_secret_access_key=$AWS_SECRET_ACCESS_KEY" \
    --var "docker_email=$DOCKER_EMAIL" \
    --var "docker_user=$DOCKER_USER" \
    --var "docker_pass=$DOCKER_PASS" \
    --var "docker_repo_terraform=$DOCKER_USER/terraform" \
    -p $PIPELINE_NAME -n

$fly unpause-pipeline -p $PIPELINE_NAME

