# var input values
app_name    = "dockerzon"
cluster     = "dockerzon"
domain_name = "*.theparrodise.com"

vpc_name = "dockerzon-ecs-vpc"

# asg
# ecs ami ami-06862a6ef1260bb02
# ec2 ami ami-086be9e7a208dad05
max_size_asg         = 4
min_size_asg         = 1
desired_capacity_asg = 1
ami                  = "ami-06862a6ef1260bb02"
key_name             = "dockerzon-ecs"

instance_attributes  = "{\\\"location\\\": \\\"instanceOne\\\"}"

# vpc_id   = "vpc-01f2c79f328ce1caf"

# vpc_public_subnets = {
#   "2a" = "subnet-0d01e5855712bc5c1"
#   "2b" = "subnet-09d6e839d44e7ea34"
# }

# vpc_private_subnets = {
#   "2a" = "subnet-039ab86b3ad621233"
#   "2b" = "subnet-0d6ed92658dd2da83"
# }

# app_sg_id = "sg-09847148c0ef7a66f"
# lb_sg_id  = "sg-0b7429161a2cc32ae"

