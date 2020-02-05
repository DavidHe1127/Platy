# var input values
# ecs ami ami-06862a6ef1260bb02
# ec2 ami ami-086be9e7a208dad05
ami               = "ami-06862a6ef1260bb02"
app_name          = "dockerzon"
cluster           = "dockerzon"
instance_key_name = "test-terraform-vpc-provisioning"

vpc_id   = "vpc-0c8dfb97911324204"
vpc_name = "dockerzon-ecs-vpc"

vpc_public_subnets = {
  "2a" = "subnet-0d2f33a67fd2fafdd"
  "2b" = "subnet-09dbd04aef523cc8f"
}

vpc_private_subnets = {
  "2a" = "subnet-0b7c60a2ef364280f"
  "2b" = "subnet-0d50ff82e398882b3"
}

app_sg_id = "sg-01d8e4518dae3e783"
lb_sg_id  = "sg-0d96dd81025c83852"
