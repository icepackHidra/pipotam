resource "proxmox_virtual_environment_vm" "windows_server_vm" {
  for_each   = {
    for index, vm in local.windows_serv_vms:
    vm.name => vm #pour chaque vm la clé est vm .name (la valeur de each.key)
  }
  name      = "${each.value.vm_hostname}"
  node_name = var.target_node

  on_boot = each.value.onboot

  operating_system {
    type = "win10"
  }

  agent {
    enabled = true
  }

  tags = concat(var.vm_tags , ["windows", "server"], each.value.tags != null ? each.value.tags : [])

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
    vm_id = var.windows_serv_golden_vm_id
    retries = 5
  }

  timeout_clone = var.timeout_clone

}


resource "proxmox_virtual_environment_vm" "windows_client_vm" {
  for_each   = {
    for index, vm in local.windows_client_vms:
    vm.name => vm #pour chaque vm la clé est vm .name (la valeur de each.key)
  }
  name      = "${each.value.vm_hostname}"
  node_name = var.target_node

  on_boot = each.value.onboot

  operating_system {
    type = "win10"
  }

  agent {
    enabled = true
  }

  tags = concat(var.vm_tags , ["windows", "client"])

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
    model   = "e1000"
  }

  # Ignore changes to the network
  ## MAC address is generated on every apply, causing
  ## TF to think this needs to be rebuilt on every apply
  lifecycle {
    ignore_changes = [
      network_device,
    ]
  }

  boot_order    = ["ide0"]
  scsi_hardware = "virtio-scsi-single"

  disk {
    interface    = "ide0"
    iothread     = true
    datastore_id = "${each.value.disk.storage}"
    size         = each.value.disk.size
    discard      = "ignore"
  
  }

  clone {
    vm_id = var.windows_client_golden_vm_id
    retries = 5
  }

  timeout_clone = var.timeout_clone
  

}
