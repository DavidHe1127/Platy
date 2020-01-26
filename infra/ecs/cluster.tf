resource "aws_ecs_cluster" "dockerzon" {
  name = "dockerzon"

  tags = {
    Name = "dockerzon-cluster"
  }
}
