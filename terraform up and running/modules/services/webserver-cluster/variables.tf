variable "security_group_name" {
  description = "The name of the security group"
  type        = string
  default     = "terraform-example-instance"
}

variable "server_port" {
  description = "The port the server will use for HTTP requests."
  type        = number
  default     = 8080
}

variable "cluster_name" {
  description = "The name to use for all the clsuter resources"
  type        = string
}

variable "db_remote_state_bucket" {
  description = "The name of the s3 buvket for the database's remote state"
  type        = string
}

variable "db_remote_state_key" {
  description = "the path for the database's remote state in s3"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2isntances to run (e.g. t2.micro)"
  type        = string
}

variable "min_size" {
  description = "The minimum number of EC2 instances in the ASG"
  type        = number
}

variable "max_size" {
  description = "The maximum number of EC2 instances in the ASG"
  type        = number
}

variable "custom_tags" {
  description = "Custom tags to set on the Instances in the ASG"
  type        = map(string)
  default     = {}
}

# local vars
locals {
  http_port    = 80
  any_port     = 0
  any_protocol = "-1"
  tcp_protocol = "tcp"
  all_ips      = ["0.0.0.0/0"]
}
