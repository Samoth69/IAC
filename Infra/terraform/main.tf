terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.68.1"
    }
  }
}

provider "proxmox" {
  endpoint = "https://192.168.0.7:8006/"
  insecure = true
  api_token = var.proxmox_ve_token

  ssh {
    username = var.proxmox_ve_username
    password = var.proxmox_ve_password
  }
}
