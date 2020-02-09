# var input values
# ecs ami ami-06862a6ef1260bb02
# ec2 ami ami-086be9e7a208dad05
ami               = "ami-06862a6ef1260bb02"
app_name          = "dockerzon"
cluster           = "dockerzon"
instance_key_name = "test-terraform-vpc-provisioning"

vpc_id   = "vpc-0360353734b9ac4e1"
vpc_name = "dockerzon-ecs-vpc"

vpc_public_subnets = {
  "2a" = "subnet-00fe7ee12c7c54dbe"
  "2b" = "subnet-02ef2fa7d34f8c6c1"
}

vpc_private_subnets = {
  "2a" = "subnet-0c88324cc6864097a"
  "2b" = "subnet-0054b9343c7e16592"
}

app_sg_id = "sg-087e5fd6d5eb62e17"
lb_sg_id  = "sg-0afd7c6b8921a9f2e"
