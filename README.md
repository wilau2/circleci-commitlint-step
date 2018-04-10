[![CircleCI](https://circleci.com/gh/wilau2/circleci-validate-commit-msg/tree/master.svg?style=svg)](https://circleci.com/gh/wilau2/circleci-validate-commit-msg/tree/master)

# Circleci 2.0 example

Circleci commit message validation with `commitlint` npm package

## What it does? 

- Branch `master` is working in [circleci](https://circleci.com/gh/wilau2/circleci-validate-commit-msg/tree/master)

- Branch `wrong-commit-name` is failing in [circleci](https://circleci.com/gh/wilau2/circleci-validate-commit-msg/tree/example-wrong-commit-name)

## Use 
Add the following step to your circleci `config.yml`:

```
version: 2
references:
  container_config: &circleci-commitlint
    docker:
      - image: williamlauze/circleci-commitlint:latest
    working_directory: /www
jobs:
  commitlint:
    <<: *circleci-commitlint
    steps:
      - checkout
      - run:
          name: commitlint
          command: |
            /bin/sh /.scripts/commitlint_range.sh

workflows:
  version: 2
  my_pipeline:
    jobs:
      - commitlint
```

## References

- [commitlint](https://github.com/marionebl/commitlint)
- [commitizen](https://github.com/commitizen/cz-cli)
