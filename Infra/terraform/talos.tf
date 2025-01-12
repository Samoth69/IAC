variable "talos-nodes" {
  type = map(object({
    node   = string
    vmid   = number
    ip     = string
    mac    = string
    memory = number
    cpu    = number
    })
  )
  default = {
    "1" = {
      node   = "akame"
      vmid   = 610
      ip     = "192.168.1.10/24"
      mac    = "00:01:10"
      memory = 48 * 1024
      cpu    = 10
    },
    "2" = {
      node   = "bipboop"
      vmid   = 611
      ip     = "192.168.1.11/24"
      mac    = "00:01:11"
      memory = 8 * 1024
      cpu    = 2
    },
    "3" = {
      node   = "felix"
      vmid   = 612
      ip     = "192.168.1.12/24"
      mac    = "00:01:12"
      memory = 32 * 1024
      cpu    = 12
    }
  }
}

module "talos-node" {
  source    = "./talos-node"
  for_each  = var.talos-nodes
  is_master = true

  machine_name    = "k3s-${each.key}"
  target_node     = each.value.node
  vmid            = each.value.vmid
  tags            = ["k8s"]
  iso_path        = "cephfs:iso/talos-v1.9.1-nocloud-amd64.iso"
  timeout_stop_vm = 600
  cpu_cores       = each.value.cpu
  memory          = each.value.memory
  storage         = "local-lvm"
  storage_size    = 50
  bridge          = "VNLAN"
  ip_address      = each.value.ip
  mac_address     = each.value.mac
}
