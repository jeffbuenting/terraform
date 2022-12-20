output "alb_dns_name" {
  value       = module.hello-world.alb_dns_name
  description = "The domain of the load balancer"
}
