# resource "aws_instance" "web" {
#   ami                    = var.ami
#   instance_type          = "t2.micro"
#   key_name               = var.key_name
#   user_data              = templatefile("ec2/bootstrap/index.sh", { cluster = var.cluster, attribute = lookup(var.attributes, count.index + 1) })
#   vpc_security_group_ids = [var.app_sg_id]
#   iam_instance_profile   = aws_iam_instance_profile.instance-profile.name

#   count     = var.instance_count
#   subnet_id = element(var.subnets, count.index)

#   tags = {
#     Name = "${var.name}-0${count.index + 1}"
#   }
# }

resource "aws_autoscaling_group" "dockerzon-cluster-asg" {
  name                      = "DockerzonClusterASG"
  max_size                  = var.max_size_asg
  min_size                  = var.min_size_asg
  desired_capacity          = var.desired_capacity_asg
  vpc_zone_identifier       = var.subnets
  target_group_arns         = var.target_group_arns
  health_check_type         = "EC2"
  health_check_grace_period = 301
  service_linked_role_arn   = var.ecs_cluster_auto_scaling_role_arn

  launch_template {
    id      = aws_launch_template.dockerzon-asg.id
    version = "$Latest"
  }
}
