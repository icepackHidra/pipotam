locals {
  windows_serv_vms = [
    {
      vm_hostname = "DC1-capu"
      name = "DC1-capu"
      domain       = "pipotam.local"
      cores = 2
      sockets = 1
      memory = 2048
      disk = {
        storage = "local-lvm"
        size    = "30"
      }
      onboot = true
      tags = ["DC"]
    },
   {
      vm_hostname = "DC2-capu"
      name = "DC2-capu"
      domain       = "pipotam.local"
      cores = 2
      sockets = 1
      memory = 4096
      disk = {
        storage = "local-lvm"
        size    = "30"
      }
      onboot = true
      tags = ["ADCS", "DC"]
    },
    {
      vm_hostname = "WEB-capu"
      name = "WEB-capu"
      domain       = "pipotam.local"
      cores = 2
      sockets = 1
      memory = 2048
      disk = {
        storage = "local-lvm"
        size    = "30"
      }
      onboot = true
      tags = ["IIS"]
    }  
  ]
}