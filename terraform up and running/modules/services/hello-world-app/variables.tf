variable "security_group_name" {
  description = "The name of the security group"
  type        = string
  default     = "terraform-example-instance"
}





variable "db_remote_state_bucket" {
  description = "The name of the s3 buvket for the database's remote state"
  type        = string
}

variable "db_remote_state_key" {
  description = "the path for the database's remote state in s3"
  type        = string
}





# variable "enable_new_user_data" {
#   description = "if set to true, use the new User Script"
#   type        = bool
# }

# variable "name" {
#   description = "a name to render"
#   value       = string
# }



variable "server_text" {
  description = "The text the web server should return"
  default     = "Hello, World"
  type        = string
}

variable "environment" {
  description = "The name of the environment we're deploying to"
  type        = string
}

# local vars
locals {
  http_port    = 80
  any_port     = 0
  any_protocol = "-1"
  tcp_protocol = "tcp"
  all_ips      = ["0.0.0.0/0"]
}
