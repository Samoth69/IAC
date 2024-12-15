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
    architecture = "x86_64"
    cores        = var.cpu_cores
    type         = "host"
    flags        = ["+aes"]
  }

  memory {
    dedicated = var.memory
    floating  = var.memory
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
    model  = "virtio"
    bridge = var.bridge
  }

  cdrom {
    enabled   = true
    file_id   = var.iso_path
    interface = "ide0"
  }

  vga {
    type   = "std"
    memory = 16
  }
}
