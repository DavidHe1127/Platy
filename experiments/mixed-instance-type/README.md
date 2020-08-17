## Mixed instance type in ASG

It allows you to launch ec2s with multiple instance types. i.e spot + on-demand mix. This setup not only helps you meet the workload demand, but also offers you big savings in running cost.

### Key points

- `on-demand` instances uses `prioritised` strategy. i.e use order of instance type in the list of launch template overrides. You order them by moving them up or down. The first instance type in the list is prioritized higher than the last. If all your On-Demand capacity cannot be fulfilled using your highest priority instance, then the EC2 Fleet launches the remaining capacity using the second priority instance type, and so on.
- `spot` instances allow `capacity optimised` (recommended) or `lowest price`.
- Instances weighting example
- Spot instances will either be interrupted by higher bidding price OR insufficient capacity.

|   | Total  |
|---|--------|
|   |   20   |
| on-demand instance  |    5    |
| over base on-demand 80%   |   12     |
| over base spot 80%   |   8     |


### Best practices

- Use default max price which is on-demand price.
- Use multiple instance types
- When using `lowest price`, to lower the impact of spot instance interruptions, specify a high number of spot instance pools. i.e set pool count to 10 when running critical mission like a web application or 2 when running a non-critical mission like batch job.
- Setup event bridge to send 2 minute warning to SNS/lambda prior to spot instance terminations.
