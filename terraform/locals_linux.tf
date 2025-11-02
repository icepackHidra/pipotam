locals {
  debian_vms = [
     {
      vm_hostname = "pilipili"
      name = "pilipili"
      domain       = "pipotam.local"
      cores = 1
      sockets = 1
      memory = 2048
      disk = {
        storage = "local-lvm"
        size    = "20"
      }
      onboot = true

    } 
  ]
}