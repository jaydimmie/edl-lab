terraform {
  required_providers {
    panos = {
      source  = "PaloAltoNetworks/panos"
      version = "~> 1.11"
    }
  }
}

provider "panos" {
  hostname = "192.168.137.21"
  username = "admin"
  password = var.firewall_password
}

resource "panos_edl" "test_edl" {
  name        = "terraform-test-edl"
  type        = "ip"
  source      = "http://192.168.137.1:8080/blocklist.txt"
  repeat      = "every five minutes"
  description = "EDL created by Terraform"
}

resource "panos_edl" "infoblox_domains" {
  name        = "infoblox-malicious-domains"
  type        = "domain"
  source      = "http://192.168.137.1:8080/domains.txt"
  repeat      = "hourly"
  description = "Malicious domains from Infoblox feed"
}
