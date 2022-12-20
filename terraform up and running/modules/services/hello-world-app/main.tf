

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# data "terraform_remote_state" "db" {
#   backend = "s3"

#   config = {
#     bucket = "jdb-terraform-state"
#     key    = "stage/data-stores/mysql/terraform.tfstate"
#     region = "us-east-1"
#   }
# }

data "template_file" "user_data" {
  # count = var.enable_new_user_data ? 0 : 1

  template = file("${path.module}/user_data.sh")

  vars = {
    server_port = var.server_port
    db_address  = 1
    db_port     = 3306
    #   # db_address  = data.terraform_remote_state.db.outputs.address
    #   # db_port     = data.terraform_remote_state.db.outputs.port
    server_text = var.server_text
  }
}

# data "template_file" "user_data_new" {
#   count = var.enable_new_user_data ? 1 : 0

#   template = file("${path.module}/user_data_new.sh")

#   vars = {
#     server_port = var.server_port
#   }
# }


resource "aws_lb_listener_rule" "asg" {
  listener_arn = module.alb.alb_http_listener_arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.asg.arn
  }
}

resource "aws_lb_target_group" "asg" {
  name     = "hello-world-${var.environment}"
  port     = var.server_port
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

module "asg" {
  source = "../../cluster/asg-rolling-deploy"

  cluster_name  = "hello-world-${var.environment}"
  ami           = var.ami
  user_data     = data.template_file.user_data.rendered
  instance_type = var.instance_type

  min_size           = var.min_size
  max_size           = var.max_size
  enable_autoscaling = var.enable_autoscaling

  subnet_ids        = data.aws_subnets.default.ids
  target_group_arns = [aws_lb_target_group.asg.arn]
  health_check_type = "ELB"

  custom_tags = var.custom_tags
}

module "alb" {
  source = "../../networking/alb"

  alb_name   = "hello-world-${var.environment}"
  subnet_ids = data.aws_subnets.default.ids
}
