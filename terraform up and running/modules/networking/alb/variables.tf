variable "alb_name" {
  description = "the name to use for this ALB"
  type        = string
}

variable "subnet_ids" {
  description = "IDs of the vpc where the ALB will be created."
  type        = list(string)
}

# local vars
locals {
  http_port    = 80
  any_port     = 0
  any_protocol = "-1"
  tcp_protocol = "tcp"
  all_ips      = ["0.0.0.0/0"]
}
