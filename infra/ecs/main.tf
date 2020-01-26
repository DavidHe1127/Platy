
≈



Use ec2 module and provide the below as input

ami-06862a6ef1260bb02
count = 3

type = t2.micro

instance-profile = new role with AmazonEC2ContainerServiceRole as policy

keyname = test-terraform-vpc-provisioning

user data = copy ecs.config /etc/ecs/ecs.config

