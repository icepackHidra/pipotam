terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox" 
      version = "0.85.1"   
    }
  }
}

provider "proxmox" {
  endpoint = var.pve_api_url
  username = var.pve_user
  insecure = true
  api_token = var.api_token
  ssh {
    agent    = false
    private_key = var.pve_ssh_key_private
    username = "root"
  }
 random_vm_ids = true
 random_vm_id_start = 1000
 random_vm_id_end = 2000
 
}
