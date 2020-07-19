data "terraform_remote_state" "ecs-state" {
  backend = "s3"

  config = {
    bucket  = "dave-dockerzon-ecs-tfstate"
    key     = var.ecs_state_file_key
    region  = "ap-southeast-2"
    profile = "qq"
  }
}
