#!/usr/bin/env bash
set -o errexit
#set -o nounset

#For debugging purposes
# set -o xtrace
# set -o pipefail

if [ -n "$CIRCLE_PULL_REQUEST" ]
then
  echo "This is a pull request"
  PULL_REQUEST_NUMBER=$(echo "${CIRCLE_PULL_REQUEST}" | cut -d/ -f7)
  BASE_SHA1=$(curl https://api.github.com/repos/${CIRCLE_PROJECT_USERNAME}/${CIRCLE_PROJECT_REPONAME}/pulls/${PULL_REQUEST_NUMBER} | jq -r .base.sha)
  HEAD_SHA1=$(curl https://api.github.com/repos/${CIRCLE_PROJECT_USERNAME}/${CIRCLE_PROJECT_REPONAME}/pulls/${PULL_REQUEST_NUMBER} | jq -r .head.sha)
  COMMIT_RANGE="${BASE_SHA1}...${HEAD_SHA1}"
  git log ${COMMIT_RANGE} --pretty=%B | commitlint
else
  echo "This is a normal commit range"
  COMMIT_RANGE=$(echo "${CIRCLE_COMPARE_URL}" | cut -d/ -f7)
  git log ${COMMIT_RANGE} --pretty=%B | commitlint
fi