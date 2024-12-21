variable "talos-control-nodes" {
  type = map(any)
  default = {
    "Akame" = {
      vmid = 610
      ip   = "192.168.1.10/24"
    },
    "Felix" = {
      vmid = 611
      ip   = "192.168.1.11/24"
    },
    "Yukine" = {
      vmid = 612
      ip   = "192.168.1.12/24"
    }
  }
}

module "talos-control" {
  source   = "./talos-node"
  for_each = var.talos-control-nodes

  machine_name    = "MilimControl${each.key}"
  target_node     = lower(each.key)
  vmid            = each.value.vmid
  tags            = ["milim"]
  iso_path        = "cephfs:iso/talos-v1.9.0-nocloud-amd64.iso"
  timeout_stop_vm = 600
  cpu_cores       = 4
  memory          = 4 * 1024
  storage         = "local-lvm"
  storage_size    = 20
  bridge          = "VNLAN"
  ip_address      = each.value.ip
}

variable "talos-worker-nodes" {
  type = map(any)
  default = {
    "Akame" = {
      vmid = 620
      ip   = "192.168.1.20/24"
    },
    # "Felix" = {
    #   vmid = 621
    #   ip   = "192.168.1.21/24"
    # },
    "Yukine" = {
      vmid = 622
      ip   = "192.168.1.22/24"
    }
  }
}

module "talos-worker" {
  source   = "./talos-node"
  for_each = var.talos-worker-nodes

  machine_name    = "MilimWorker${each.key}"
  target_node     = lower(each.key)
  vmid            = each.value.vmid
  tags            = ["milim"]
  iso_path        = "cephfs:iso/talos-v1.9.0-nocloud-amd64.iso"
  timeout_stop_vm = 300
  cpu_cores       = 8
  memory          = 24 * 1024
  storage         = "local-lvm"
  storage_size    = 50
  bridge          = "VNLAN"
  ip_address      = each.value.ip
}