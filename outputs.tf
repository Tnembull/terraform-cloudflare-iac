output "apex_domain" {
  description = "Apex domain name"
  value       = var.domain_name
}

output "vps_ip" {
  description = "Target VPS IPv4"
  value       = var.vps_ipv4
}

output "provisioned_subdomains" {
  description = "List of production subdomains managed by this module"
  value       = [for k, v in local.subdomains : "${k}.${var.domain_name}"]
}

output "ssl_security_profile" {
  description = "Edge SSL and TLS policy"
  value = {
    ssl_mode    = "full"
    min_tls     = "1.2"
    https_force = true
  }
}
