## VPC

It creates a custom vpc with:

- 2 public subnets
- 2 private subnets
- an internet gateway
- a route table
- load balancer security group
- ec2 security group

It also creates 3 endpoints:

- Amazon ECS - allow ecs-agent on ec2 to communicate with ecs master plane
- Amazon ECR - allow instances to download image manifest
- Gateway Amazon S3 - allow instances to download image layers from underlying private Amazon S3 buckets that host them

[Setting up AWS PrivateLink for Amazon ECS, and Amazon ECR](https://aws.amazon.com/blogs/compute/setting-up-aws-privatelink-for-amazon-ecs-and-amazon-ecr/)
