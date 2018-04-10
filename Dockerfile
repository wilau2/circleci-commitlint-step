FROM node:9.5.0-alpine

RUN apk add --update bash git openssh curl jq

COPY commitlint_range.sh .scripts/commitlint_range.sh

RUN npm install -g @commitlint/cli @commitlint/config-conventional

RUN echo "module.exports = {extends: ['@commitlint/config-conventional']}" > commitlint.config.js

WORKDIR www