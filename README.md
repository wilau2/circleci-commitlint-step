# Circleci 2.0 example

commit message validation with validate-commit-msg npm package

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
          name:
          command: |
            COMMIT_RANGE=$(echo "${CIRCLE_COMPARE_URL}" | cut -d/ -f7)
            sh /.scripts/validate-commit-message.sh ${COMMIT_RANGE}
workflows:
  version: 2
  my_pipeline:
    jobs:
      - validate_commitizen
```

## Utils
getting commit range on a PR
`COMMIT_RANGE=$(echo "${CIRCLE_COMPARE_URL}" | cut -d/ -f7)`