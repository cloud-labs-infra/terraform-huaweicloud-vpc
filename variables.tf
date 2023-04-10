variable "name" {
  description = "Specifies the name of the VPC"
  type        = string
  nullable    = false
  validation {
    condition     = length(var.name) <= 64
    error_message = "The value is a string of no more than 64 characters and can contain digits, letters, underscores (_), and hyphens (-)."
  }
}

variable "region" {
  description = "Specifies the region in which to create the resource, if omitted, the provider-level region will be used"
  type        = string
  default     = null
}

variable "description" {
  description = " Specifies supplementary information about the VPC"
  type        = string
  default     = null
}

variable "cidr" {
  description = "Specifies the range of available subnets in the VPC"
  type        = string
}

variable "secondary_cidr" {
  description = "Specifies the secondary CIDR block of the VPC"
  type        = string
  default     = null
}

variable "availability_zones" {
  description = "Specify the Availability Zone in the Region in in which to create the subnets, if omitted, AZ calculates automatically"
  type        = list(string)
  default     = []
}

variable "subnets" {
  type = object({
    private = list(string)
    public  = list(string)
  })
}

variable "private_to_internet" {
  description = "Enable access to the Internet from private subnets"
  type        = bool
  default     = false
}

variable "primary_dns" {
  description = "Specifies the IP address of DNS server 1 on the subnets"
  type        = string
  default     = null
}

variable "secondary_dns" {
  description = "Specifies the IP address of DNS server 2 on the subnets"
  type        = string
  default     = null
}

variable "dns_list" {
  description = "Specifies the DNS server address list of the subnets, it is required if you need to use more than two DNS servers"
  type        = list(string)
  default     = null
}

variable "dhcp_enable" {
  description = "Specifies whether the DHCP function is enabled for the subnets"
  type        = bool
  default     = true
}

variable "ipv6_enable" {
  description = "Specifies whether the IPv6 function is enabled for the subnet"
  type        = bool
  default     = false
}

variable "nat_spec" {
  description = "Specifies the specification of the NAT gateway"
  type        = string
  default     = "1"
  validation {
    condition     = contains(["1", "2", "3", "4"], var.nat_spec)
    error_message = "The valid values are as follows: '1': 10,000 SNAT connections, '2': 50,000 SNAT connections, '3': 200,000 SNAT connections, '4': 1,000,000 SNAT connections."
  }
}

variable "nat_snat_floating_ip_ids" {
  description = "Specifies the IDs of floating IPs connected by SNAT rule"
  type        = list(string)
}

variable "allow_internal_traffic" {
  description = "Allow all traffic from public to private subnets"
  type        = bool
  default     = true
}

variable "network_acl_rule_public" {
  type = map(object({
    type                   = string                  # inbound or outbound
    enabled                = optional(bool, true)    # Enabled status for the network ACL rule
    protocol               = optional(string, "any") # Valid values are: tcp, udp, icmp and any.
    action                 = string                  # Currently, the value can be allow or deny.
    ip_version             = optional(number, 4)     # Specifies the IP version - 4 or 6
    source_ip_address      = string                  # Specifies the source IP address that the traffic is allowed from
    source_port            = string                  # Specifies the destination port number or port number range
    destination_ip_address = string                  # Specifies the destination IP address to which the traffic is allowed
    destination_port       = string                  # Specifies the destination port number or port number range.
  }))
  default = {
    allow_all_in = {
      type                   = "inbound"
      enabled                = true
      protocol               = "any"
      action                 = "allow"
      ip_version             = 4
      source_ip_address      = "0.0.0.0/0"
      source_port            = null
      destination_ip_address = "0.0.0.0/0"
      destination_port       = null
    }
    allow_all_out = {
      type                   = "outbound"
      enabled                = true
      protocol               = "any"
      action                 = "allow"
      ip_version             = 4
      source_ip_address      = "0.0.0.0/0"
      source_port            = null
      destination_ip_address = "0.0.0.0/0"
      destination_port       = null
    }
  }
}

variable "network_acl_rule_private" {
  type = map(object({
    type                   = string                  # inbound or outbound
    enabled                = optional(bool, true)    # Enabled status for the network ACL rule
    protocol               = optional(string, "any") # Valid values are: tcp, udp, icmp and any.
    action                 = string                  # Currently, the value can be allow or deny.
    ip_version             = optional(number, 4)     # Specifies the IP version - 4 or 6
    source_ip_address      = string                  # Specifies the source IP address that the traffic is allowed from
    source_port            = string                  # Specifies the destination port number or port number range
    destination_ip_address = string                  # Specifies the destination IP address to which the traffic is allowed
    destination_port       = string                  # Specifies the destination port number or port number range.
  }))
  default = {}
}

variable "tags" {
  description = "Specifies the key/value pairs to associate with the VPC"
  type        = map(string)
  default     = {}
}
