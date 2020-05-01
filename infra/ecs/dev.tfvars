# var input values
app_name          = "dockerzon"
cluster           = "dockerzon"
domain_name       = "*.theparrodise.com"

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

