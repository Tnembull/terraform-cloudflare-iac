variable "cloudflare_api_token" {
  description = "Cloudflare API Token with Zone.DNS and Zone.Settings permissions"
  type        = string
  sensitive   = true
}

variable "cloudflare_zone_id" {
  description = "The Zone ID of the apex domain (e.g., muhammadnurashiddiqi.my.id)"
  type        = string
}

variable "vps_ipv4" {
  description = "Primary IPv4 address of the target VPS"
  type        = string
  default     = "192.0.2.1"
}

variable "domain_name" {
  description = "Apex domain name managed by this Terraform module"
  type        = string
  default     = "example.com"
}
