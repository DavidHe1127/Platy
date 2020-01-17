resource "aws_instance" "web" {
  ami             = var.ami
  instance_type   = "t2.micro"
  key_name        = "test-terraform-vpc-provisioning"
  # user_data       = templatefile("ec2/install_apache.sh", { server = "0${var.instance_count}" })
  security_groups = [aws_security_group.app-instance-sg.id]

  count     = var.instance_count
  subnet_id = element(var.subnets, count.index)

  tags = {
    Name = "${var.name}-0${count.index}"
  }
}
