variable "cluster_name" {
  description = "The name to use forall the cluster resources"
  type        = string
}

variable "db_remote_state_bucket" {
  description = "The name of the S3 bucket for the database's remote state"
  type        = string
}

variable "db_remote_state_key" {
  description = "the path for the database's remote state in S3"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instances to run (e.g t2.micro)"
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
  type        = map(any)
  default     = {}
}

variable "enable_autoscaling" {
  description = "If set to true, enable auto scaling"
  type        = bool
}

locals {
  http_port    = 80
  any_port     = 0
  any_protocol = -1
  tcp_protocol = "tcp"
  all_ips      = ["0.0.0.0/0"]
}


