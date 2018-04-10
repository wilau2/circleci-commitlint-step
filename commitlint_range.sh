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
else
  COMMIT_RANGE=$(echo "${CIRCLE_COMPARE_URL}" | cut -d/ -f7)
  FIRST_COMMIT=$(echo "${COMMIT_RANGE}" | cut -d. -f1)
  echo "This is a normal commit range: ${COMMIT_RANGE} with first commit: ${FIRST_COMMIT}"
  if git cat-file -e ${FIRST_COMMIT}; then
    echo "${FIRST_COMMIT} exists"
  else
    echo "${FIRST_COMMIT} does not exist"
    echo "rebase support is limited will compare against master"
    COMMIT_RANGE=origin/master...${CIRCLE_SHA1}
  fi
fi
echo "${COMMIT_RANGE}"
git log ${COMMIT_RANGE} --pretty=%B | commitlint