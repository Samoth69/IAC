variable "machine_name" {
  type = string
}

variable "target_node" {
  type = string
}

variable "vmid" {
  type = number
}

variable "tags" {
  type    = list(string)
  default = []
}


variable "started" {
  type    = bool
  default = true
}

variable "onboot" {
  type    = bool
  default = true
}


variable "cpu_cores" {
  type    = number
  default = 1
}

variable "memory" {
  type    = number
  default = 1024
}

variable "storage" {
  type    = string
  default = "local-lvm"
}

variable "storage_size" {
  type    = string
  default = 8
}

variable "file_format" {
  type    = string
  default = "raw"
}

variable "timeout_stop_vm" {
  type    = number
  default = 600
}

variable "bridge" {
  type    = string
  default = "vlan1"
}

variable "iso_path" {
  type     = string
  nullable = true
}

variable "ip_address" {
  type = string
}

variable "ip_gateway" {
  type    = string
  default = "192.168.1.1"
}

variable "mac_address" {
  type = string
}

variable "is_master" {
  type    = bool
  default = false
}

variable "kube_node_name" {
  type = string
}
