## Rolling update to AMIs on container instances

### Prerequisite

- Try with `minimumHealthyPercent` set to **100%** which will ensure the replaced tasks are `RUNNING` and healthy before
ECS scheduler does its job to terminate old tasks deployed on old instances

### Steps

- Scale cluster up by adding one time the current cluster size. i.e add 2 more instances
- Call api to drain existing instances
- Keep asking on 10 seconds basis to see if there is any tasks running on old instances
  - If there is none, then terminate old instances and scale back down to original size.
  ```shell
    aws autoscaling terminate-instance-in-auto-scaling-group --instance-id XXXX --should-decrement-desired-capacity 2
  ```
