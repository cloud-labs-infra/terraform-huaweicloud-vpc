# Huawei Cloud VPC
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.7 |
| <a name="requirement_huaweicloud"></a> [huaweicloud](#requirement\_huaweicloud) | ~>1.63 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_huaweicloud"></a> [huaweicloud](#provider\_huaweicloud) | ~>1.63 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [huaweicloud_nat_gateway.main](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/nat_gateway) | resource |
| [huaweicloud_nat_snat_rule.private](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/nat_snat_rule) | resource |
| [huaweicloud_nat_snat_rule.public](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/nat_snat_rule) | resource |
| [huaweicloud_network_acl.private](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/network_acl) | resource |
| [huaweicloud_network_acl.public](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/network_acl) | resource |
| [huaweicloud_network_acl_rule.private_inbound](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/network_acl_rule) | resource |
| [huaweicloud_network_acl_rule.private_inbound_default](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/network_acl_rule) | resource |
| [huaweicloud_network_acl_rule.private_outbound](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/network_acl_rule) | resource |
| [huaweicloud_network_acl_rule.private_outbound_default](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/network_acl_rule) | resource |
| [huaweicloud_network_acl_rule.public_inbound](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/network_acl_rule) | resource |
| [huaweicloud_network_acl_rule.public_outbound](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/network_acl_rule) | resource |
| [huaweicloud_vpc.main](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/vpc) | resource |
| [huaweicloud_vpc_subnet.private](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/vpc_subnet) | resource |
| [huaweicloud_vpc_subnet.public](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/resources/vpc_subnet) | resource |
| [huaweicloud_availability_zones.zones](https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_internal_traffic"></a> [allow\_internal\_traffic](#input\_allow\_internal\_traffic) | Allow all traffic from public to private subnets | `bool` | `true` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | Specify the Availability Zone in the Region in in which to create the subnets, if omitted, AZ calculates automatically | `list(string)` | `[]` | no |
| <a name="input_cidr"></a> [cidr](#input\_cidr) | Specifies the range of available subnets in the VPC | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | Specifies supplementary information about the VPC | `string` | `null` | no |
| <a name="input_dhcp_enable"></a> [dhcp\_enable](#input\_dhcp\_enable) | Specifies whether the DHCP function is enabled for the subnets | `bool` | `true` | no |
| <a name="input_dns_list"></a> [dns\_list](#input\_dns\_list) | Specifies the DNS server address list of the subnets, it is required if you need to use more than two DNS servers | `list(string)` | `null` | no |
| <a name="input_ipv6_enable"></a> [ipv6\_enable](#input\_ipv6\_enable) | Specifies whether the IPv6 function is enabled for the subnet | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Specifies the name of the VPC | `string` | n/a | yes |
| <a name="input_nat_snat_floating_ip_ids"></a> [nat\_snat\_floating\_ip\_ids](#input\_nat\_snat\_floating\_ip\_ids) | Specifies the IDs of floating IPs connected by SNAT rule | `list(string)` | n/a | yes |
| <a name="input_nat_spec"></a> [nat\_spec](#input\_nat\_spec) | Specifies the specification of the NAT gateway | `string` | `"1"` | no |
| <a name="input_network_acl_rule_private"></a> [network\_acl\_rule\_private](#input\_network\_acl\_rule\_private) | n/a | <pre>map(object({<br>    type                   = string                  # inbound or outbound<br>    enabled                = optional(bool, true)    # Enabled status for the network ACL rule<br>    protocol               = optional(string, "any") # Valid values are: tcp, udp, icmp and any.<br>    action                 = string                  # Currently, the value can be allow or deny.<br>    ip_version             = optional(number, 4)     # Specifies the IP version - 4 or 6<br>    source_ip_address      = string                  # Specifies the source IP address that the traffic is allowed from<br>    source_port            = string                  # Specifies the destination port number or port number range<br>    destination_ip_address = string                  # Specifies the destination IP address to which the traffic is allowed<br>    destination_port       = string                  # Specifies the destination port number or port number range.<br>  }))</pre> | `{}` | no |
| <a name="input_network_acl_rule_public"></a> [network\_acl\_rule\_public](#input\_network\_acl\_rule\_public) | n/a | <pre>map(object({<br>    type                   = string                  # inbound or outbound<br>    enabled                = optional(bool, true)    # Enabled status for the network ACL rule<br>    protocol               = optional(string, "any") # Valid values are: tcp, udp, icmp and any.<br>    action                 = string                  # Currently, the value can be allow or deny.<br>    ip_version             = optional(number, 4)     # Specifies the IP version - 4 or 6<br>    source_ip_address      = string                  # Specifies the source IP address that the traffic is allowed from<br>    source_port            = string                  # Specifies the destination port number or port number range<br>    destination_ip_address = string                  # Specifies the destination IP address to which the traffic is allowed<br>    destination_port       = string                  # Specifies the destination port number or port number range.<br>  }))</pre> | <pre>{<br>  "allow_all_in": {<br>    "action": "allow",<br>    "destination_ip_address": "0.0.0.0/0",<br>    "destination_port": null,<br>    "enabled": true,<br>    "ip_version": 4,<br>    "protocol": "any",<br>    "source_ip_address": "0.0.0.0/0",<br>    "source_port": null,<br>    "type": "inbound"<br>  },<br>  "allow_all_out": {<br>    "action": "allow",<br>    "destination_ip_address": "0.0.0.0/0",<br>    "destination_port": null,<br>    "enabled": true,<br>    "ip_version": 4,<br>    "protocol": "any",<br>    "source_ip_address": "0.0.0.0/0",<br>    "source_port": null,<br>    "type": "outbound"<br>  }<br>}</pre> | no |
| <a name="input_primary_dns"></a> [primary\_dns](#input\_primary\_dns) | Specifies the IP address of DNS server 1 on the subnets | `string` | `null` | no |
| <a name="input_private_to_internet"></a> [private\_to\_internet](#input\_private\_to\_internet) | Enable access to the Internet from private subnets | `bool` | `false` | no |
| <a name="input_region"></a> [region](#input\_region) | Specifies the region in which to create the resource, if omitted, the provider-level region will be used | `string` | `null` | no |
| <a name="input_secondary_cidr"></a> [secondary\_cidr](#input\_secondary\_cidr) | Specifies the secondary CIDR block of the VPC | `string` | `null` | no |
| <a name="input_secondary_dns"></a> [secondary\_dns](#input\_secondary\_dns) | Specifies the IP address of DNS server 2 on the subnets | `string` | `null` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | n/a | <pre>object({<br>    private = list(string)<br>    public  = list(string)<br>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Specifies the key/value pairs to associate with the VPC | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_subnets_cidrs"></a> [private\_subnets\_cidrs](#output\_private\_subnets\_cidrs) | List of CIDRs of Private Subnets |
| <a name="output_private_subnets_ids"></a> [private\_subnets\_ids](#output\_private\_subnets\_ids) | List of IDs of Private Subnets in UUID format |
| <a name="output_private_subnets_subnet_ids"></a> [private\_subnets\_subnet\_ids](#output\_private\_subnets\_subnet\_ids) | List of IDs of the IPv4 subnet (Native OpenStack API) |
| <a name="output_public_subnets_cidrs"></a> [public\_subnets\_cidrs](#output\_public\_subnets\_cidrs) | List of CIDRs of Public Subnets |
| <a name="output_public_subnets_ids"></a> [public\_subnets\_ids](#output\_public\_subnets\_ids) | List of IDs of Public Subnets in UUID format |
| <a name="output_public_subnets_subnet_ids"></a> [public\_subnets\_subnet\_ids](#output\_public\_subnets\_subnet\_ids) | List of IDs of the IPv4 subnet (Native OpenStack API) |
| <a name="output_vpc_cidr"></a> [vpc\_cidr](#output\_vpc\_cidr) | The CIDR of the VPC |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The VPC ID in UUID format |
| <a name="output_vpc_status"></a> [vpc\_status](#output\_vpc\_status) | The current status of the VPC |
<!-- END_TF_DOCS -->