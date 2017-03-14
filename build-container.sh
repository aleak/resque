#!/bin/bash -e

# requirements
# 1. docker
# 2. awscli
# 3. jq

if [ -z "$AWS_PROFILE_NAME" ]; then
  echo "Need to set AWS_PROFILE_NAME"
  exit 1
fi

REPO_NAME=rp/resque-web
REPO_TAG=latest

# create if not exists
# aws ecr create-repository --repository-name $REPO_NAME --profile $AWS_PROFILE_NAME

ECR_REPO=`aws ecr describe-repositories --repository-names $REPO_NAME --profile $AWS_PROFILE_NAME | jq -r '.repositories[0].repositoryUri'`

docker build -t $REPO_NAME:$REPO_TAG .

`aws ecr get-login --profile $AWS_PROFILE_NAME`

docker tag $REPO_NAME:$REPO_TAG $ECR_REPO:$REPO_TAG
docker push $ECR_REPO:$REPO_TAG
