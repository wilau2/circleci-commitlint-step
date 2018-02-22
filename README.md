# Circleci 2.0 example

Circleci commit message validation with `validate-commit-msg` npm package

## How to use it? 
It is very simple. Just add the following to you circleci `config.yml`:

```
version: 2
references:
  container_config: &circleci-validate-commit-msg
    docker:
      - image: williamlauze/circleci-validate-commit-msg:latest
    working_directory: /www

jobs:
  validate_commitizen:
    <<: *circleci-validate-commit-msg
    steps:
      - checkout
      - run:
          name: validate commit message
          command: |
            COMMIT_RANGE=$(echo "${CIRCLE_COMPARE_URL}" | cut -d/ -f7)
            sh /.scripts/validate-commit-message.sh ${COMMIT_RANGE}
workflows:
  version: 2
  my_pipeline:
    jobs:
      - validate_commitizen
```

## How to build your own? 
Fork this project. Change the `validate-commit-msg` version in the `Dockerfile`
```
npm run docker:build
npm run docker:push
```

## Contribute
If you think you can make this circleci job step better. Don't be shy to create a pull request.

## Utils
getting commit range on a PR
`COMMIT_RANGE=$(echo "${CIRCLE_COMPARE_URL}" | cut -d/ -f7)`

## References

- [validate-commit-msg](https://www.npmjs.com/package/validate-commit-msg)
- [commitizen](https://github.com/commitizen/cz-cli)
