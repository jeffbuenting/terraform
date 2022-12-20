provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

module "asg" {
  source = "../../modules/cluster/asg-rolling-deploy"

  cluster_name = "asg_example"
  ami          = "ami-08c40ec9ead489470"
  # user_data     = data.template_file.user_data.rendered
  instance_type = "t2.micro"

  min_size           = 1
  max_size           = 1
  enable_autoscaling = false

  subnet_ids = data.aws_subnets.default.ids
  # target_group_arns = [aws_lb_target_group.asg.arn]
  # health_check_type = "ELB"

  # custom_tags = var.custom_tags
}
