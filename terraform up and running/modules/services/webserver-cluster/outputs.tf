# output "userdata_rendered" {
#   value       = data.template_file.user_data.rendered
#   description = "rendered userdata"
# }

# output "asg_name" {
#   value       = aws_autoscaling_group.example.name
#   description = "The name of the auto scaling group"
# }

# output "alb_dns_name" {
#   value       = aws_lb.example.dns_name
#   description = "The domain name of the load balancer"
# }

output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "The public IP address of he web server."
}
