resource "aws_launch_template" "dockerzon-asg" {
  name = "DockerzonASGLaunchTemplate"

  image_id      = var.ami
  instance_type = var.instance
  key_name      = var.key

  vpc_security_group_ids = var.vpc_security_group_ids

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = 30
      delete_on_termination = true
      volume_type           = "gp2"
    }
  }

  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    description                 = "Dockerzon ASG launch template"
    device_index                = 0
    security_groups             = var.app_instance_sg_ids
  }

  iam_instance_profile {
    name = var.instance_profile
  }

  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Origin = "Lauched by Dockerzon ASG launch template"
    }
  }

  # Network interfaces and instance-level security groups can not be specified together
  user_data = filebase64("${path.module}/example.sh")
}




# resource "aws_launch_template" "foobar" {
#   name_prefix   = "foobar"
#   image_id      = "ami-1a2b3c"
#   instance_type = "t2.micro"
# }

# resource "aws_autoscaling_group" "bar" {
#   availability_zones = ["us-east-1a"]
#   desired_capacity   = 1
#   max_size           = 1
#   min_size           = 1

#   launch_template {
#     id      = "${aws_launch_template.foobar.id}"
#     version = "$Latest"
#   }
# }
