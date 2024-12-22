variable "talos-control-nodes" {
  type = map(any)
  default = {
    "Akame" = {
      vmid = 610
      ip   = "192.168.1.10/24"
      mac  = "00:01:10"
    },
    "Felix" = {
      vmid = 611
      ip   = "192.168.1.11/24"
      mac  = "00:01:11"
    },
    "Yukine" = {
      vmid = 612
      ip   = "192.168.1.12/24"
      mac  = "00:01:12"
    }
  }
}

module "talos-control" {
  source    = "./talos-node"
  for_each  = var.talos-control-nodes
  is_master = true

  machine_name    = "MilimControl${each.key}"
  kube_node_name  = "milim-control-${lower(each.key)}"
  target_node     = lower(each.key)
  vmid            = each.value.vmid
  tags            = ["milim"]
  iso_path        = null # "cephfs:iso/talos-v1.9.0-nocloud-amd64.iso"
  timeout_stop_vm = 600
  cpu_cores       = 4
  memory          = 6 * 1024
  storage         = "local-lvm"
  storage_size    = 20
  bridge          = "VNLAN"
  ip_address      = each.value.ip
  mac_address     = each.value.mac
}

variable "talos-worker-nodes" {
  type = map(any)
  default = {
    "Akame" = {
      vmid = 620
      ip   = "192.168.1.20/24"
      mac  = "00:01:20"
    },
    # "Felix" = {
    #   vmid = 621
    #   ip   = "192.168.1.21/24"
    #   mac  = "00:01:21"
    # },
    "Yukine" = {
      vmid = 622
      ip   = "192.168.1.22/24"
      mac  = "00:01:22"
    }
  }
}

module "talos-worker" {
  source     = "./talos-node"
  for_each   = var.talos-worker-nodes
  depends_on = [module.talos-control]

  machine_name    = "MilimWorker${each.key}"
  kube_node_name  = "milim-worker-${lower(each.key)}"
  target_node     = lower(each.key)
  vmid            = each.value.vmid
  tags            = ["milim"]
  iso_path        = null # "cephfs:iso/talos-v1.9.0-nocloud-amd64.iso"
  timeout_stop_vm = 300
  cpu_cores       = 8
  memory          = 24 * 1024
  storage         = "local-lvm"
  storage_size    = 50
  bridge          = "VNLAN"
  ip_address      = each.value.ip
  mac_address     = each.value.mac
}
