## Learning notes

### Security Group
- ELB security rules guide. see [Elastic Load Balancing Rules
](https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/security-group-rules-reference.html#sg-rules-elb)

### ECS deployment configuration

It controls how ECS will update your running service when you push application updates. Default deployment type is `rolling update` meaning you update one service at a time until all services have been updated while maintaining zero downtime.

```json
{
  "desiredCount": 2,
  "deploymentConfiguration": {
    "maximumPercent": 100,
    "minimumHealthyPercent": 50
  }
}
```

- `maximumPercent` - represents an upper limit on the number of your service's tasks that are **allowed** in the RUNNING or PENDING state during a deployment. It must be at least `100`.

- `minimumHealthyPercent` - represents a lower limit on the number of your service's tasks that **must remain in the RUNNING state** during a deployment.

AWS uses formula below:

```java
desiredCount * ([maximumPercent|minimumHealthyPercent] / 100) = count

When `maximumPercent` is used in the formula, it is the number of your service's tasks that are **allowed** in the RUNNING or PENDING state during deployment.

When `minimumHealthyPercent` is used in the formula, it is the number of your service's tasks that **must remain in RUNNING state** during deployment
```

**Example One**

```json
{
  "desiredCount": 4,
  "deploymentConfiguration": {
    "maximumPercent": 200
  }
}
```

Calculation result is `8` which means ECS may start `4` NEW tasks before stopping four OLD tasks (provided that the cluster resources required to do this are available).

**Example Two**

```json
{
  "desiredCount": 2,
  "deploymentConfiguration": {
    "maximumPercent": 100
  }
}
```

Calculation result is `2` which means ECS may start `2` NEW tasks before stopping 2 OLD tasks (provided that the cluster resources required to do this are available).

**Example Three**

```json
{
  "desiredCount": 2,
  "deploymentConfiguration": {
    "maximumPercent": 100,
    "minimumHealthyPercent": 50
  }
}
```

Calculation result is `2` and `1` which means ECS may start `2` NEW tasks before stopping 1 OLD tasks (provided that the cluster resources required to do this are available). And the count of RUNNING tasks must be `1`.

**Example Four**

```json
{
  "desiredCount": 3,
  "deploymentConfiguration": {
    "maximumPercent": 100,
    "minimumHealthyPercent": 33
  }
}
```

Max no. of tasks are allowed to be in `RUNNING` or `PENDING` state  is `3 * (100 / 100) = 3`.
Min no. of tasks must be running during update is `3 * (33 / 100) = 1`.

**Example Five**

```json
{
  "desiredCount": 3,
  "deploymentConfiguration": {
    "maximumPercent": 100,
    "minimumHealthyPercent": 50
  }
}
```

Max no. of tasks are allowed to be in `RUNNING` or `PENDING` state is `3 * (100 / 100) = 3`.
Min no. of tasks must be running during update is `3 * (50 / 100) = 2`.

[More examples](https://stackoverflow.com/questions/40731143/what-is-the-minimum-healthy-percent-and-maximum-percent-in-amazon-ecs)
