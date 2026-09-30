# ==============================================================================
# 1. Apex Domain & WWW Proxy Records
# ==============================================================================

# Apex record pointing to VPS IP with Cloudflare CDN & DDoS Protection
resource "cloudflare_record" "apex" {
  zone_id = var.cloudflare_zone_id
  name    = "@"
  value   = var.vps_ipv4
  type    = "A"
  proxied = true
  ttl     = 1 # Auto TTL when proxied
  comment = "Managed by Terraform: Main developer portfolio root"
}

# WWW CNAME Record
resource "cloudflare_record" "www" {
  zone_id = var.cloudflare_zone_id
  name    = "www"
  value   = var.domain_name
  type    = "CNAME"
  proxied = true
  ttl     = 1
  comment = "Managed by Terraform: WWW canonical alias"
}

# ==============================================================================
# 2. Production Subdomains
# ==============================================================================

locals {
  subdomains = {
    "drive"  = "BulinDrive Telegram-backed Cloud Video Vault"
    "chat"   = "BulinChat AI Studio & LLM Workspace"
    "router" = "9router Multi-Model AI Gateway reverse-proxy"
    "love"   = "Interactive Personal Keepsake Subdomain"
  }
}

resource "cloudflare_record" "services" {
  for_each = local.subdomains

  zone_id = var.cloudflare_zone_id
  name    = each.key
  value   = var.vps_ipv4
  type    = "A"
  proxied = true
  ttl     = 1
  comment = "Managed by Terraform: ${each.value}"
}

# ==============================================================================
# 3. Cloudflare Edge SSL / TLS & Security Baseline
# ==============================================================================

# Enforce Full (Strict) SSL encryption between Cloudflare edge and Origin Nginx
resource "cloudflare_zone_settings_override" "security_baseline" {
  zone_id = var.cloudflare_zone_id

  settings {
    ssl                      = "full"
    always_use_https         = "on"
    min_tls_version          = "1.2"
    opportunistic_encryption = "on"
    tls_1_3                  = "on"
    automatic_https_rewrites = "on"
    security_level           = "medium"
    brotli                   = "on"
  }
}
