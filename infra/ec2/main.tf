resource "aws_instance" "web" {
  ami           = "ami-0119aa4d67e59007c"
  instance_type = "t2.micro"
  key_name      = "test-terraform-vpc-provisioning"
  user_data     = templatefile("ec2/install_apache.sh", { server = "01" })
  security_groups = var.security_groups

  count     = var.instance_count
  subnet_id = element(var.subnets, count.index)

  tags = {
    Name = element(var.names, count.index)
  }
}
