## Cluster Auto Scaling Key Points

- CAS relies on ECS capacity providers, which provide the link between your ECS cluster and the ASGs you want to use.
- Previously, tasks that cannot be placed due to insufficient compute resources will fail immediately. Now with managed scaling policy enabled in capacity provider, tasks will go into provisioning state instead and later be deployed when more instances come up as result of scale out. Currently, it allows 100 tasks in provisioning state to be queued.

#### Scaling Design/Strategy

We use `M` to represent the right number of instances and `N` to represent the current number of instances.

- 2 factors work hand in hand to help determine scaling activity - metric and target. CAS uses a new CloudWatch metric call `CapacityProviderReservation`. Target corresponds to `Target Capacity` defined in `CAS` without %.

```
CapacityProviderReservation = M / N * 100
```

Above formula calculates the value of this metric. At the end of the day, scaling aims to make `target` equal to/get close to `CapacityProviderReservation` by adjusting `N`. Adjustments indicates scale in/out activity.

Examples:

```shell
#1 Given M = 2, N = 3 and Target = 100

CapacityProviderReservation = 66 (2 / 3 * 100)

Scaling policy needs to tweak N so computed result equals 100. So it will remove one instance to bring N down to 2. As a result, 2 / 2 * 100 = 100
In this process, a scale in activity is carried out.

One thing to note is, set target to be 100 means all instances are fully used. In other words, no more tasks can be placed on them unless new instances are launched.

#2 Given M = 2, N = 3 and Target = 50

CapacityProviderReservation = 66.6 (2 / 3 * 100)

Likewise, scaling policy will add 1 more instance to meet target value that is 50.

Also to note, setting target to value below 100 means spare capacity. In the above example, we will always make sure 50% instances are idle and not running any tasks on them. Besides, below-100 value makes scaling to zero impossible.

#3 Given M = 0, N = 2 and Target = 100

When M is 0, it means no tasks are running apart from daemon one. In this case, CapacityProviderReservation will be equal to Target only if M = N. Given M is 0, scaling policy will zero N out by scaling in 2 instances.

```

#### Reference

[Deep dive on CAS](https://aws.amazon.com/blogs/containers/deep-dive-on-amazon-ecs-cluster-auto-scaling/)
