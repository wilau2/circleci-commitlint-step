FROM node:9.5.0-alpine

RUN apk add --update bash git

COPY validate-commit-message.sh .scripts/validate-commit-message.sh

RUN cd www; npm install

RUN npm install validate-commit-msg -g

WORKDIR www