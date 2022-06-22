<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.44.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | ~> 2.1.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.1.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.44.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ec2_tag.k8s-Master](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_flow_log.flow_log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_internet_gateway.IGW_K8S](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_network_acl.Public_NACL](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl) | resource |
| [aws_route.internet_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.Public_RT](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.Public_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.allow_k8s](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_spot_instance_request.k8s-Node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/spot_instance_request) | resource |
| [aws_spot_instance_request.k8s-master](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/spot_instance_request) | resource |
| [aws_spot_instance_request.vpn-access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/spot_instance_request) | resource |
| [aws_subnet.k8s-subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.k8s-vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_s3_bucket_object.ssh-key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket_object) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_NodeHostname"></a> [NodeHostname](#input\_NodeHostname) | n/a | `string` | `"node"` | no |
| <a name="input_ami"></a> [ami](#input\_ami) | n/a | `string` | `"ami-09e67e426f25ce0d7"` | no |
| <a name="input_availabilityZone"></a> [availabilityZone](#input\_availabilityZone) | # Network | `string` | n/a | yes |
| <a name="input_dnsHostNames"></a> [dnsHostNames](#input\_dnsHostNames) | n/a | `bool` | `true` | no |
| <a name="input_dnsSupport"></a> [dnsSupport](#input\_dnsSupport) | n/a | `bool` | `true` | no |
| <a name="input_egressCIDRblock"></a> [egressCIDRblock](#input\_egressCIDRblock) | n/a | `list(any)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_ingressCIDRblock"></a> [ingressCIDRblock](#input\_ingressCIDRblock) | n/a | `list(any)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_instancetypeMaster"></a> [instancetypeMaster](#input\_instancetypeMaster) | n/a | `string` | `"t2.medium"` | no |
| <a name="input_instancetypeNode"></a> [instancetypeNode](#input\_instancetypeNode) | n/a | `string` | `"t2.micro"` | no |
| <a name="input_instancetypeVPN"></a> [instancetypeVPN](#input\_instancetypeVPN) | # VPN | `string` | `"t2.micro"` | no |
| <a name="input_ipAddress"></a> [ipAddress](#input\_ipAddress) | n/a | `list(any)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | n/a | `string` | n/a | yes |
| <a name="input_localdestCIDRblock"></a> [localdestCIDRblock](#input\_localdestCIDRblock) | n/a | `string` | `"10.0.0.0/16"` | no |
| <a name="input_mapPublicIP"></a> [mapPublicIP](#input\_mapPublicIP) | n/a | `bool` | `true` | no |
| <a name="input_master_machine_name"></a> [master\_machine\_name](#input\_master\_machine\_name) | n/a | `string` | `"master"` | no |
| <a name="input_nameVPN"></a> [nameVPN](#input\_nameVPN) | n/a | `string` | `"VPNAccess"` | no |
| <a name="input_privatesCIDRblock"></a> [privatesCIDRblock](#input\_privatesCIDRblock) | n/a | `string` | `"10.0.2.0/24"` | no |
| <a name="input_publicdestCIDRblock"></a> [publicdestCIDRblock](#input\_publicdestCIDRblock) | n/a | `string` | `"0.0.0.0/0"` | no |
| <a name="input_publicsCIDRblock"></a> [publicsCIDRblock](#input\_publicsCIDRblock) | n/a | `string` | `"10.0.1.0/24"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"us-east-1"` | no |
| <a name="input_spotpriceMaster"></a> [spotpriceMaster](#input\_spotpriceMaster) | n/a | `number` | n/a | yes |
| <a name="input_spotpriceMicro"></a> [spotpriceMicro](#input\_spotpriceMicro) | n/a | `string` | `"0.0035"` | no |
| <a name="input_spotpriceNode"></a> [spotpriceNode](#input\_spotpriceNode) | n/a | `number` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `string` | `"master"` | no |
| <a name="input_vpcCIDRblock"></a> [vpcCIDRblock](#input\_vpcCIDRblock) | CIDR Block of VPC | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_public_ip_Master"></a> [public\_ip\_Master](#output\_public\_ip\_Master) | n/a |
| <a name="output_public_ip_Node"></a> [public\_ip\_Node](#output\_public\_ip\_Node) | n/a |
| <a name="output_public_ip_VPN"></a> [public\_ip\_VPN](#output\_public\_ip\_VPN) | n/a |
<!-- END_TF_DOCS -->