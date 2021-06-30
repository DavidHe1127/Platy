## Mixed instance type in ASG

It allows you to launch ec2s with multiple instance types. i.e spot + on-demand mix. This setup not only helps you meet the workload demand, but also offers you big savings in running cost.

### Key points

- `on-demand` instances uses `prioritised` strategy. i.e use order of instance type in the list of launch template overrides. You order them by moving them up or down. The first instance type in the list is prioritized higher than the last. If all your On-Demand capacity cannot be fulfilled using your highest priority instance, then the EC2 Fleet launches the remaining capacity using the second priority instance type, and so on.
- `spot` instances allow `capacity optimised` (recommended) or `lowest price`.
- Instances weighting example

|   | Total  |
|---|--------|
|   |   20   |
| on-demand instance  |    5    |
| over base on-demand 60%   |   9     |
| over base spot 40%   |   6     |
- Spot instances will either be interrupted by higher bidding price OR insufficient capacity.

### Best practices

- Use default max price which is on-demand price. That way, your spot instances will not be terminated due to prices increase. But could still be terminated because AWS might not have enough capacity in the Spot instance pool.
- Use multiple instance types
- When using `lowest price`, to lower the impact of spot instance interruptions, specify a high number of spot instance pools. i.e set pool count to 10 when running critical mission like a web application or 2 when running a non-critical mission like batch job.
- Setup event bridge to send 2 minute warning to SNS/lambda prior to spot instance terminations.

### Terraform example

Mixed instance type config is not implemented in the existing infra tf script. The following example is to illustrate how you can create it.

```tf
resource "aws_autoscaling_group" "example" {
  availability_zones = ["us-east-1a"]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.example.id
      }

      override {
        instance_type     = "c4.large"
        weighted_capacity = "3"
      }

      override {
        instance_type     = "c3.large"
        weighted_capacity = "2"
      }
    }
  }
}
```
