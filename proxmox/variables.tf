variable "api_url" {
  type = string
  #default = "https://proxmox-server01.example.com:8006/api2/json"
}

variable "hostname" {
  type        = string
  default     = "LXC"
  description = "Specifies the host name of the container."
}

variable "ostemplate" {
  type        = string
  description = "The volume identifier that points to the OS template or backup file. e.g. : local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
}


variable "password" {
  type        = string
  description = "Sets the root password inside the container."
  sensitive   = true
}

variable "unprivileged" {
  type        = bool
  description = "A boolean that makes the container run as an unprivileged user."
  default     = false
}

variable "rootfs" {
  type = object({
    size    = string,
    storage = string
  })
  default = {
    size    = "8G",
    storage = "local-lvm"
  }
}

