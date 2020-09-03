## DataDog

### Goal

Enable monitoring for ECS service.

### Workflow

- Setup IAM role DD assumes to query CloudWatch/ECS for metrics/data. See `iam_role.tf`
- Install AWS Integrations through DataDog Console
- Create task definition for agent
- Launch DD agent as a daemon service

### Takeaway

- Using external id to grant 3rd party permissions to access resources in your account.
```
"Principal": {"AWS": "Example Corp's AWS Account ID"},
"Condition": {"StringEquals": {"sts:ExternalId": "Unique ID Assigned by Example Corp"}}
... other policies
```

- Service running as a Daemon will ensure exact one task is deployed on each container instance in a given cluster. i.e when more ec2s are added to cluster as a result of
scale-out, ECS scheduler will spawn a new task in each of them.

### References

- [Monitoring ECS using DataDog](https://www.datadoghq.com/blog/monitoring-ecs-with-datadog/)
- [How to Use an External ID When Granting Access to Your AWS Resources to a Third Party](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-user_externalid.html)
- [ECS Daemon service](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs_services.html#service_scheduler_daemon)
