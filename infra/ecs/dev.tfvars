# var input values
# ecs ami ami-06862a6ef1260bb02
# ec2 ami ami-086be9e7a208dad05
ami               = "ami-06862a6ef1260bb02"
app_name          = "dockerzon"
cluster           = "dockerzon"
instance_key_name = "dockerzon-ecs"

vpc_id   = "vpc-01f2c79f328ce1caf"
vpc_name = "dockerzon-ecs-vpc"

vpc_public_subnets = {
  "2a" = "subnet-0d01e5855712bc5c1"
  "2b" = "subnet-09d6e839d44e7ea34"
}

vpc_private_subnets = {
  "2a" = "subnet-039ab86b3ad621233"
  "2b" = "subnet-0d6ed92658dd2da83"
}

app_sg_id = "sg-09847148c0ef7a66f"
lb_sg_id  = "sg-0b7429161a2cc32ae"
