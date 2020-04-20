## ASG on ECS

### 2 types
2 scaling aspects include cluster scaling and service scaling.

#### Cluster Scaling
It is for scaling cluster up/down by adding/removing container instances as per demand to suffice resources requirement for running more/less tasks in a service.

#### Service Scaling
It is for scaling service up/down by adding/removing tasks in a service.

### Process
To enable ASG on ECS, a number of things need to be configured:

#### CloudWatch

Create alarms to monitor certain metrics i.e CPUUTILIZATION

#### ECS Service

Update service to enable scaling policy for reaction when linked alarm is triggered i.e use step scaling policy in response to triggered alarms

#### ASG

Add cluster scaling


### Notes
- `Minimum number of tasks/Maximum number of tasks` sets the scaling boundary that encloses `desired number of tasks`.
- `1024` CPU units corresponds to `1` vCPU.

### instance's user data in Launch Configuration

```sh
#!/bin/bash

sudo curl -o /usr/local/bin/ecs-cli https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-linux-amd64-latest
sudo chmod +x /usr/local/bin/ecs-cli
ecs-cli --version

echo ECS_INSTANCE_ATTRIBUTES={\"location\":\"instanceOne\"} > /etc/ecs/ecs.config
echo ECS_CLUSTER=dockerzon >> /etc/ecs/ecs.config
```

---

## Alarms

### Datapoints/Period/Evaluation Periods

Define the number of `datapoints` within the `evaluation period` that must be breaching to cause the alarm to go to ALARM state.

`Period` defines the smallest unit of each time period.

i.e Given Period being 6 hours, Evaluation Period being 8 and Datapoints being 7, it means when alarm threshold has been hit 7 times during 8 * 6 hours, the alarm state will be changed to `IN ALARM`.

Likewise, given Period being 1 minute, Evaluation Period being 3 and Datapoints being 3, it means when alarm threshold has been reached in 3 consecutive periods during 3 * 1 minutes, the alarm state will be changed to `IN ALARM`.

### Outstanding issues

- Terraform ASG
- Prove req is served by launched instance/tasks
