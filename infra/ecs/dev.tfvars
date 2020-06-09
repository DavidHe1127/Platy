# var input values
app_name    = "dockerzon"
cluster     = "dockerzon"
domain_name = "*.theparrodise.com"

vpc_name = "dockerzon-ecs-vpc"

# asg
# ecs ami ami-06862a6ef1260bb02
# ec2 ami ami-086be9e7a208dad05
# new ecs ami ami-02446908683d78c79
max_size_asg         = 4
min_size_asg         = 3
desired_capacity_asg = 3

ami                  = "ami-06862a6ef1260bb02"
# ami                  = "ami-02446908683d78c79"
key_name             = "dockerzon-ecs"

instance_attributes          = "{\\\"location\\\": \\\"instanceOne\\\"}"
prerequisites_state_file_key = "dockerzon-ecs-prerequisites-terraform.tfstate"
