resource "aws_ecr_repository" "dockerzon-express" {
  name = "dockerzon-express"

  # image_scanning_configuration {
  #   scan_on_push = true
  # }

  tags = {
    Name = "dockerzon-express-ecr-repo"
  }
}

resource "aws_ecr_repository" "dockerzon-nginx" {
  name = "dockerzon-nginx"

  # image_scanning_configuration {
  #   scan_on_push = true
  # }

  tags = {
    Name = "dockerzon-nginx-ecr-repo"
  }
}
