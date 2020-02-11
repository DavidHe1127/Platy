# var input values
# ecs ami ami-06862a6ef1260bb02
# ec2 ami ami-086be9e7a208dad05
ami               = "ami-06862a6ef1260bb02"
app_name          = "dockerzon"
cluster           = "dockerzon"
instance_key_name = "dockerzon-ecs"

vpc_id   = "vpc-04e0233d2c5f5bf83"
vpc_name = "dockerzon-ecs-vpc"

vpc_public_subnets = {
  "2a" = "subnet-029de357c4c20931f"
  "2b" = "subnet-0a56837ac1b74fd52"
}

vpc_private_subnets = {
  "2a" = "subnet-0aca70665069b0991"
  "2b" = "subnet-0faec041e5e22498c"
}

app_sg_id = "sg-0aa281b289e88b9c3"
lb_sg_id  = "sg-0be742bc466dd7184"
