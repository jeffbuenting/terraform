output "alb_dns_name" {
  value       = aws_lb.example.dns_name
  description = "The domain name of the load balancer"
}

output "userdata_rendered" {
  value       = data.template_file.user_data.rendered
  description = "rendered userdata"
}
