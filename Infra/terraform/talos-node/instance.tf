resource "proxmox_virtual_environment_vm" "node" {
  name      = var.machine_name
  node_name = var.target_node
  vm_id     = var.vmid
  tags      = var.tags

  on_boot         = var.onboot
  started         = var.started
  tablet_device   = false
  timeout_stop_vm = var.timeout_stop_vm
  boot_order      = ["scsi0", "ide0"]

  operating_system {
    type = "l26"
  }

  startup {
    order      = var.is_master ? "1" : "2"
    up_delay   = var.is_master ? "30" : "90"
    down_delay = var.is_master ? "60" : "0"
  }

  agent {
    enabled = true
    type    = "virtio"
    timeout = "10s"
  }

  bios = "ovmf"
  efi_disk {
    datastore_id      = var.storage
    file_format       = var.file_format
    type              = "4m"
    pre_enrolled_keys = false
  }

  machine = "q35"

  cpu {
    cores        = var.cpu_cores
    type         = "host"
    flags        = ["+aes"]
    units        = 100
  }

  memory {
    dedicated = var.memory
    floating  = var.memory
  }

  initialization {
    ip_config {
      ipv4 {
        address = var.ip_address
        gateway = var.ip_gateway
      }
    }
    dns {
      servers = [
        "192.168.0.2",
        "192.168.0.3",
      ]
    }
  }

  scsi_hardware = "virtio-scsi-single"

  disk {
    # TODO déterminer si c'est réellement gagnant par rapport à io_uring
    aio          = "native"
    backup       = false
    datastore_id = var.storage
    discard      = "on"
    file_format  = var.file_format
    interface    = "scsi0"
    iothread     = true
    size         = var.storage_size
    ssd          = true
  }

  network_device {
    model       = "virtio"
    bridge      = var.bridge
    mac_address = format("bc:24:11:%s", var.mac_address)
  }

  cdrom {
    enabled   = true
    file_id   = var.iso_path != null ? var.iso_path : "none"
    interface = "ide0"
  }

  vga {
    type   = "std"
    memory = 16
  }
}

resource "null_resource" "wait_for_node_to_be_ready" {
  depends_on = [ proxmox_virtual_environment_vm.node ]

  provisioner "local-exec" {
    command = "kubectl wait --for=condition=Ready node ${var.kube_node_name}"
  }
}