<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 2.9.10 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 2.9.10 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_lxc.basic](https://registry.terraform.io/providers/Telmate/proxmox/2.9.10/docs/resources/lxc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_url"></a> [api\_url](#input\_api\_url) | n/a | `string` | n/a | yes |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | Specifies the host name of the container. | `string` | `"LXC"` | no |
| <a name="input_ostemplate"></a> [ostemplate](#input\_ostemplate) | The volume identifier that points to the OS template or backup file. e.g. : local:vztmpl/ubuntu-22.04-standard\_22.04-1\_amd64.tar.zst | `string` | n/a | yes |
| <a name="input_password"></a> [password](#input\_password) | Sets the root password inside the container. | `string` | n/a | yes |
| <a name="input_rootfs"></a> [rootfs](#input\_rootfs) | n/a | <pre>object({<br>    size    = string,<br>    storage = string<br>  })</pre> | <pre>{<br>  "size": "8G",<br>  "storage": "local-lvm"<br>}</pre> | no |
| <a name="input_unprivileged"></a> [unprivileged](#input\_unprivileged) | A boolean that makes the container run as an unprivileged user. | `bool` | `false` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->