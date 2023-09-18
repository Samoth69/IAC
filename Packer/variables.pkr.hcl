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