variable "nodes" {
  type    = set(string)
  default = ["Akame", "Felix", "Yukine"]
}

module "talos-controlpanes" {
  source   = "./talos-node"
  for_each = var.nodes

  machine_name    = "MilimControlpane${each.key}"
  target_node     = lower(each.key)
  vmid            = sum([600, index(tolist(var.nodes), each.key)])
  tags            = ["milim"]
  iso_path        = "cephfs:iso/nocloud-amd64.iso"
  timeout_stop_vm = 300
  cpu_cores       = 4
  memory          = 4 * 1024
  storage         = "local-lvm"
  storage_size    = 20
  bridge          = "vlan1"
}
