variable "api_token" {
  description = "Proxmox API Token Value."
  sensitive   = true
}

variable "pve_api_url" {
  description = "https://192.168.1.15:8006/api2/json"
  type        = string
  sensitive   = true
  validation {
    condition     = can(regex("(?i)^http[s]?://.*/api2/json$", var.pve_api_url))
    error_message = "Proxmox API Endpoint Invalid. Check URL - Scheme and Path required."
  }
}

## Proxmox SSH Variables
variable "pve_user" {
  description = "Proxmox username"
  type        = string
  sensitive   = true
}

variable "pve_password" {
  description = "Proxmox password for SSH"
  type        = string
  sensitive   = true
  default     = null
}

variable "pve_ssh_key_private" {
  description = "File path to private SSH key for PVE - overrides 'pve_password'"
  type        = string
  sensitive   = true
  default     = null
}

variable "debiangolden_vm_id" {
  description = "id de la vm debian golden"
  type = number
  default     = 9999
}

variable "target_node" {
  description = "nom du noeud"
  type = string
  default = "capu"
}

variable "template_tag" {
  description = "tag pour template"
  type = string
  default = "debiangolden"
}

variable "vm_tags" {
  description = "tag pour vm"
  type = list(string)
  default = ["pipotam"]
}

variable "windows_serv_golden_vm_id" {
  description = "id de la vm windows serv golden"
  type = number
  default     = 9998
}

variable "windows_client_golden_vm_id" {
  description = "id de la vm windows client golden"
  type = number
  default     = 9997
}

variable "timeout_clone" {
  description = "timeout for cloning a VM in seconds"
  type = number 
  default = 999999
}
