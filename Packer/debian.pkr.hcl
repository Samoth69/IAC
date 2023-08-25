packer {
  required_plugins {
    proxmox = {
      version = ">= 1.1.2"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

variable "proxmox_username" {
  type = string
}

variable "proxmox_password" {
  type      = string
  sensitive = true
}

variable "proxmox_node_url" {
  type    = string
  default = "https://192.168.0.5:8006/api2/json"
}

variable "proxmox_node_name" {
  type    = string
  default = "akame"
}

variable "ssh_user" {
  type = string
}

variable "ssh_password" {
  type      = string
  sensitive = true
}

variable "ssh_hashed_password" {
  type      = string
  sensitive = true
}

source "proxmox-iso" "debian-preseed" {
  # Proxmox settings
  http_interface           = "Ethernet 3"
  node                     = "${var.proxmox_node_name}"
  username                 = "${var.proxmox_username}"
  token                    = "${var.proxmox_password}"
  proxmox_url              = "${var.proxmox_node_url}"
  template_name            = "debian-12"
  template_description     = "generated on ${timestamp()}"
  unmount_iso              = true
  insecure_skip_tls_verify = true

  # VM Hardware
  cores           = 4
  memory          = 4096
  scsi_controller = "virtio-scsi-single"
  qemu_agent      = true
  bios            = "ovmf" # boot in UEFI
  iso_file        = "local:iso/debian-12.1.0-amd64-netinst.iso"
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
  network_adapters {
    bridge = "vmbr1"
    model  = "virtio"
  }

  # VM provisionning
  boot_wait = "8s"
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
  http_content = {
    "/preseed.cfg" = templatefile("${path.root}/configs/preseed.cfg", {
      ssh_hashed_password = "${var.ssh_hashed_password}"
    })
  }

  # SSH config
  ssh_password = "${var.ssh_password}"
  ssh_timeout  = "15m"
  ssh_username = "${var.ssh_user}"
}

build {
  sources = ["source.proxmox-iso.debian-preseed"]

  provisioner "shell" {
    inline = ["echo I LOVE DUCKS"]
  }
}

