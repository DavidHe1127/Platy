locals {
  user_data = {
    "1" = "{\\\"location\\\": \\\"instanceOne\\\"}"
  }
}

resource "aws_launch_template" "dockerzon-asg" {
  name = "DockerzonASGLaunchTemplate"

  image_id      = var.ami
  instance_type = var.instance
  key_name      = var.key

  # vpc_security_group_ids = var.vpc_security_group_ids

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

  user_data = base64encode(templatefile("${path.module}/../ecs/ec2/bootstrap/index.sh", { cluster = var.cluster, attribute = lookup(local.user_data, 1) }))
}
