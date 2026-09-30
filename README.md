# Cloudflare Edge Infrastructure as Code (IaC) with Terraform

Production-grade Infrastructure as Code (IaC) module managing Cloudflare DNS routing, DDoS protection, edge proxies, and SSL/TLS security baselines for `muhammadnurashiddiqi.my.id`.

---

## 🎯 Architecture & Objectives
This Terraform project automates the declarative provisioning of:
1. **Edge Proxied DNS Routing**:
   - Apex domain (`@`) and `www` CNAME routing directly to origin VPS.
   - Dynamic production subdomains (`drive`, `chat`, `router`, `love`) managed via HCL loops (`for_each`).
   - Cloudflare CDN caching and DDoS mitigation enabled (`proxied = true`).
2. **Edge SSL & Security Baseline**:
   - Full (Strict) SSL termination policy.
   - Forced HTTPS redirection (`always_use_https = on`).
   - Modern cryptographic standards: TLS 1.3 enforced, minimum TLS 1.2.
   - Automatic HTTP to HTTPS rewrites and Brotli compression.

---

## 📁 Repository Structure

```text
├── main.tf                    # Core resources: DNS records, subdomains, SSL overrides
├── variables.tf               # Input variables schema and sensitive flags
├── outputs.tf                 # Exported endpoints and security attributes
├── versions.tf                # HashiCorp Terraform & Cloudflare provider constraints
├── terraform.tfvars.example   # Safe template for local credentials
└── README.md                  # Technical documentation
```

---

## 🚀 Quickstart & Workflow

### 1. Prerequisites
- [Terraform CLI](https://developer.hashicorp.com/terraform/downloads) v1.5+
- Cloudflare API Token with `Zone.DNS` and `Zone.Settings` permissions.

### 2. Configure Credentials
Copy the example variables file:
```bash
cp terraform.tfvars.example terraform.tfvars
```
Edit `terraform.tfvars`:
```hcl
cloudflare_api_token = "YOUR_CLOUDFLARE_API_TOKEN"
cloudflare_zone_id   = "YOUR_ZONE_ID"
vps_ipv4             = "203.0.113.10"
domain_name          = "example.com"
```

### 3. Initialize Provider & Modules
Downloads the official Cloudflare provider plugin:
```bash
terraform init
```

### 4. Validate Configuration Syntax
```bash
terraform validate
```

### 5. Plan Execution (Dry-Run Preview)
Inspect the exact infrastructure delta before applying:
```bash
terraform plan
```

### 6. Apply Declarative State
```bash
terraform apply
```

---

## 🛡️ DevOps Best Practices Applied
- **Zero Secret Leaks**: `terraform.tfvars` and `.tfstate` files are protected in `.gitignore`.
- **Idempotency & State Tracking**: Terraform maintains the current desired state against Cloudflare API drift.
- **Dynamic Resource Iteration**: Leverages `for_each` and local maps to scale subdomain provisioning without code duplication.

---
**Author**: Muhammad Nur Ashiddiqi  
**Portfolio**: [muhammadnurashiddiqi.my.id](https://muhammadnurashiddiqi.my.id)  
**Role**: DevOps Engineer
