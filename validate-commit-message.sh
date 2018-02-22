#!/usr/bin/env bash
set -o errexit
set -o nounset

#For debugging purposes
# set -o xtrace
# set -o pipefail

COMMIT_RANGE=$1

git log ${COMMIT_RANGE} --pretty=%B | xargs -I {} validate-commit-msg {}