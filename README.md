# circleci-commitlint-step [![CircleCI](https://circleci.com/gh/wilau2/circleci-commitlint-step.svg?style=svg)](https://circleci.com/gh/wilau2/circleci-commitlint-step)
Commit message validation with `commitlint` npm package

## What it does? 

![alt text](https://github.com/wilau2/circleci-commitlint-step/blob/master/.github/circleci_fail.png)

![alt text](https://github.com/wilau2/circleci-commitlint-step/blob/master/.github/circleci_sucess.png)

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
