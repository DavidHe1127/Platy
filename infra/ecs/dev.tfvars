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

instance_attributes          = "{\\\"location\\\": \\\"instanceOne\\\"}"
prerequisites_state_file_key = "dockerzon-ecs-prerequisites-terraform.tfstate"
