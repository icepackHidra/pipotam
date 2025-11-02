locals {
  windows_client_vms = [
    {
      vm_hostname = "babu"
      name = "babu"
      domain       = "pipotam.local"
      cores = 2
      sockets = 1
      memory = 2048
      disk = {
        storage = "local-lvm"
        size    = "35"
      }
      onboot = true

    } 
  ]
}