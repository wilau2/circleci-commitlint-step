FROM node:9.5.0-alpine

RUN apk add --update bash git

COPY commitlint_range.sh .scripts/commitlint_range.sh

RUN npm install @commitlint/cli -g

WORKDIR www