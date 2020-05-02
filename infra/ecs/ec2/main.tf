resource "aws_autoscaling_group" "dockerzon-cluster-asg" {
  name                      = "DockerzonClusterASG"
  max_size                  = var.max_size_asg
  min_size                  = var.min_size_asg
  desired_capacity          = var.desired_capacity_asg
  vpc_zone_identifier       = var.subnets
  target_group_arns         = var.target_group_arns
  health_check_type         = "ELB"
  health_check_grace_period = 300
  service_linked_role_arn   = var.ecs_cluster_auto_scaling_role_arn

  launch_template {
    id      = aws_launch_template.dockerzon-asg.id
    version = "$Latest"
  }
}

# launch template
resource "aws_launch_template" "dockerzon-asg" {
  name = var.launch_template_name

  image_id      = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

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
    description                 = "dockerzon ECS instance ENI"
    device_index                = 0
    security_groups             = var.app_instance_sg_ids
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.instance-profile.name
  }

  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Origin = "Lauched by Dockerzon ASG launch template"
      Name   = var.name
    }
  }

  user_data = base64encode(templatefile("ec2/bootstrap/index.sh", { cluster = var.cluster, attribute = var.instance_attributes }))
}
