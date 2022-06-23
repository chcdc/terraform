resource "proxmox_lxc" "basic" {
  for_each     = var.rootfs
  target_node  = "pve"
  hostname     = var.hostname
  ostemplate   = var.ostemplate
  password     = var.password
  unprivileged = var.unprivileged

  rootfs {
    storage = each.value["storage"]
    size    = each.value["size"]
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "dhcp"
  }
}

