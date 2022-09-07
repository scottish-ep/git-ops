#!/bin/sh -l

set -e

GIT_TOKEN=$4
GIT_REPO=$5

TAG=$1
DEPLOYMENT_FILE=$2

IMAGE_REPO=$3
MATCH_PATTERN=$6

GIT_REPO_URL="https://scottish-ep:$GIT_TOKEN@$GIT_REPO"

git clone $GIT_REPO_URL

ls -la
sed "s/$MATCH_PATTERN/$TAG/g" $DEPLOYMENT_FILE
sed -i "s/$MATCH_PATTERN/$TAG/g" $DEPLOYMENT_FILE

git config --global user.name "scottish-ep"
git config --global user.email "scottish.foldep@gmail.com"
git config --global color.ui true

git add $DEPLOYMENT_FILE
git commit -m "[ci] Update $IMAGE_REPO to $TAG"
git push origin main
