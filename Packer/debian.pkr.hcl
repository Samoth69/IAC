packer {
  required_plugins {
    proxmox = {
      version = ">= 1.1.2"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

variable "password" {
  type      = string
  sensitive = true
}

variable "username" {
  type = string
}

variable "ssh_hashed_password" {
  type      = string
  sensitive = true
}

variable "ssh_password" {
  type      = string
  sensitive = true
}

variable "ssh_user" {
  type = string
}

variable "node_name" {
  type    = string
  default = "akame"
}

variable "node_url" {
  type    = string
  default = "https://192.168.0.5:8006/api2/json"
}

source "proxmox-iso" "debian-preseed" {
  boot_command = [
    "c<wait>",
    "linux /install.amd/vmlinuz ",
    "auto=true ",
    "url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ",
    "hostname=debian-template ",
    "domain=lan ",
    "interface=auto ",
    "vga=788 noprompt quiet --<enter>",
    "<wait>",
    "initrd /install.amd/initrd.gz<enter>",
    "<wait>",
    "boot<enter>"
  ]
  boot_wait = "8s"
  disks {
    disk_size    = "16G"
    storage_pool = "local-lvm"
    type         = "scsi"
  }
  efi_config {
    efi_storage_pool  = "local-lvm"
    efi_type          = "4m"
    pre_enrolled_keys = false
  }
  insecure_skip_tls_verify = true
  iso_file                 = "local:iso/debian-12.1.0-amd64-netinst.iso"
  network_adapters {
    bridge = "vmbr1"
    model  = "virtio"
  }
  http_content = {
    "/preseed.cfg" = templatefile("${path.root}/configs/preseed.cfg", {
      ssh_hashed_password = "${var.ssh_hashed_password}"
    })
  }
  http_interface       = "Ethernet 3"
  node                 = "${var.node_name}"
  token                = "${var.password}"
  proxmox_url          = "${var.node_url}"
  ssh_password         = "${var.ssh_password}"
  ssh_timeout          = "15m"
  ssh_username         = "${var.ssh_user}"
  template_description = "Debian 12, generated on ${timestamp()}"
  template_name        = "debian-12"
  unmount_iso          = true
  username             = "${var.username}"
  qemu_agent           = true
  cores                = 4
  memory               = 4096
  scsi_controller      = "virtio-scsi-single"
  bios                 = "ovmf" # boot in UEFI
}

build {
  sources = ["source.proxmox-iso.debian-preseed"]

  provisioner "shell" {
    inline = ["echo I LOVE DUCKS"]
  }
}

