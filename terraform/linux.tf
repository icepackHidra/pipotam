data "proxmox_virtual_environment_vms" "template" {
  node_name = var.target_node
  tags      = ["template", var.template_tag]
}


resource "proxmox_virtual_environment_file" "cloud_user_config" {
  for_each   = {
    for index, vm in local.debian_vms:
    vm.name => vm
  }
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.target_node

  source_raw {
    data = templatefile("cloud-init/user-data.yml", 
      {
        hostname = each.value.vm_hostname
      }
    )

    file_name = "${each.value.vm_hostname}.${each.value.domain}-ci-user.yml"
  }
}

resource "proxmox_virtual_environment_file" "cloud_meta_config" {
  for_each   = {
    for index, vm in local.debian_vms:
    vm.name => vm
  }
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.target_node

  source_raw {
    data = templatefile("cloud-init/meta_data.yml",
      {
        instance_id    = sha1(each.value.vm_hostname)
        local_hostname = each.value.vm_hostname
      }
    )

    file_name = "${each.value.vm_hostname}.${each.value.domain}-ci-meta_data.yml"
  }
}

resource "proxmox_virtual_environment_vm" "vm" {
  for_each   = {
    for index, vm in local.debian_vms:
    vm.name => vm #pour chaque vm la clé est vm .name (la valeur de each.key)
  }
  name      = "${each.value.vm_hostname}"
  node_name = var.target_node

  on_boot = each.value.onboot


  agent {
    enabled = true
  }

  tags = concat(var.vm_tags , ["linux", "server"])

  cpu {
    type    = "x86-64-v2-AES"
    cores   = each.value.cores
    sockets = each.value.sockets
    flags   = []
  }

  memory {
    dedicated = each.value.memory
  }

  network_device {
    bridge  = "vmbr1"
    model   = "virtio"
  }

  # Ignore changes to the network
  ## MAC address is generated on every apply, causing
  ## TF to think this needs to be rebuilt on every apply
  lifecycle {
    ignore_changes = [
      network_device,
    ]
  }

  boot_order    = ["scsi0"]
  scsi_hardware = "virtio-scsi-single"

  disk {
    interface    = "scsi0"
    iothread     = true
    datastore_id = "${each.value.disk.storage}"
    size         = each.value.disk.size
    discard      = "ignore"
  
  }

  clone {
    vm_id = var.debiangolden_vm_id
    retries = 5
  }

  initialization {
    # ip_config {
    #   ipv4 {
    #     address = "dhcp"
    #   }
    # }

    datastore_id         = "local"
    interface            = "ide2"
    user_data_file_id = proxmox_virtual_environment_file.cloud_user_config[each.key].id #on a besoin de each.key car avec le for on se retrouve avec une liste (each.key c'est l'index)
    meta_data_file_id    = proxmox_virtual_environment_file.cloud_meta_config[each.key].id 
  }


}
