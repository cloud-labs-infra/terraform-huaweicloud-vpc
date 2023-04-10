resource "huaweicloud_vpc" "main" {
  name           = format("%s-vpc", var.name)
  region         = var.region
  cidr           = var.cidr
  secondary_cidr = var.secondary_cidr
  description    = var.description

  tags = var.tags
}

data "huaweicloud_availability_zones" "zones" {
  region = var.region
}

resource "huaweicloud_vpc_subnet" "public" {
  count = length(var.subnets.public)

  name              = format("%s-public-subnet-%s", var.name, count.index)
  region            = var.region
  availability_zone = length(var.availability_zones) == 0 ? element(data.huaweicloud_availability_zones.zones.names, count.index) : element(var.availability_zones, count.index)
  vpc_id            = huaweicloud_vpc.main.id
  cidr              = var.subnets.public[count.index]
  gateway_ip        = cidrhost(var.subnets.public[count.index], 1)
  primary_dns       = var.primary_dns
  secondary_dns     = var.secondary_dns
  dns_list          = var.dns_list
  dhcp_enable       = var.dhcp_enable
  ipv6_enable       = var.ipv6_enable

  tags = var.tags
}

resource "huaweicloud_vpc_subnet" "private" {
  count = length(var.subnets.private)

  name              = format("%s-private-subnet-%s", var.name, count.index)
  region            = var.region
  availability_zone = length(var.availability_zones) == 0 ? element(data.huaweicloud_availability_zones.zones.names, count.index) : element(var.availability_zones, count.index)
  vpc_id            = huaweicloud_vpc.main.id
  cidr              = var.subnets.private[count.index]
  gateway_ip        = cidrhost(var.subnets.private[count.index], 1)
  primary_dns       = var.primary_dns
  secondary_dns     = var.secondary_dns
  dns_list          = var.dns_list
  dhcp_enable       = var.dhcp_enable
  ipv6_enable       = var.ipv6_enable

  tags = var.tags
}

resource "huaweicloud_nat_gateway" "main" {
  name      = format("%s-public-nat-gw", var.name)
  region    = var.region
  spec      = var.nat_spec
  vpc_id    = huaweicloud_vpc.main.id
  subnet_id = element(huaweicloud_vpc_subnet.public.*.id, 0)

  tags = var.tags
}

resource "huaweicloud_nat_snat_rule" "public" {
  count = length(huaweicloud_vpc_subnet.public.*.id)

  region         = var.region
  nat_gateway_id = huaweicloud_nat_gateway.main.id
  floating_ip_id = join(",", var.nat_snat_floating_ip_ids)
  subnet_id      = huaweicloud_vpc_subnet.public.*.id[count.index]
}

resource "huaweicloud_nat_snat_rule" "private" {
  count = var.private_to_internet ? length(huaweicloud_vpc_subnet.private.*.id) : 0

  region         = var.region
  nat_gateway_id = huaweicloud_nat_gateway.main.id
  floating_ip_id = join(",", var.nat_snat_floating_ip_ids)
  subnet_id      = huaweicloud_vpc_subnet.private.*.id[count.index]
}

resource "huaweicloud_network_acl" "public" {
  name           = format("%s-public-acl", var.name)
  subnets        = huaweicloud_vpc_subnet.public.*.id
  inbound_rules  = [for rule in huaweicloud_network_acl_rule.public_inbound : rule.id]
  outbound_rules = [for rule in huaweicloud_network_acl_rule.public_outbound : rule.id]
}

resource "huaweicloud_network_acl_rule" "public_inbound" {
  for_each = {
    for k, v in var.network_acl_rule_public : k => v if v.type == "inbound"
  }

  name                   = each.key
  enabled                = each.value.enabled
  protocol               = each.value.protocol
  action                 = each.value.action
  ip_version             = each.value.ip_version
  source_ip_address      = each.value.source_ip_address
  source_port            = each.value.source_port
  destination_ip_address = each.value.destination_ip_address
  destination_port       = each.value.destination_port
}

resource "huaweicloud_network_acl_rule" "public_outbound" {
  for_each = {
    for k, v in var.network_acl_rule_public : k => v if v.type == "outbound"
  }

  name                   = each.key
  enabled                = each.value.enabled
  protocol               = each.value.protocol
  action                 = each.value.action
  ip_version             = each.value.ip_version
  source_ip_address      = each.value.source_ip_address
  source_port            = each.value.source_port
  destination_ip_address = each.value.destination_ip_address
  destination_port       = each.value.destination_port
}

resource "huaweicloud_network_acl" "private" {
  name    = format("%s-private-acl", var.name)
  subnets = huaweicloud_vpc_subnet.private.*.id
  inbound_rules = concat(
    huaweicloud_network_acl_rule.private_inbound_default.*.id,
    [for rule in huaweicloud_network_acl_rule.private_inbound : rule.id]
  )
  outbound_rules = concat(
    huaweicloud_network_acl_rule.private_outbound_default.*.id,
    [for rule in huaweicloud_network_acl_rule.private_outbound : rule.id]
  )
}

resource "huaweicloud_network_acl_rule" "private_outbound_default" {
  count = var.allow_internal_traffic ? 1 : 0

  name                   = "default"
  description            = "Default ACL Rule allows traffic inside of VPC"
  protocol               = "any"
  action                 = "allow"
  ip_version             = 4
  source_ip_address      = var.cidr
  destination_ip_address = var.cidr
}

resource "huaweicloud_network_acl_rule" "private_inbound_default" {
  count = var.allow_internal_traffic ? 1 : 0

  name                   = "default"
  description            = "Default ACL Rule allows traffic inside of VPC"
  protocol               = "any"
  action                 = "allow"
  ip_version             = 4
  source_ip_address      = var.cidr
  destination_ip_address = var.cidr
}

resource "huaweicloud_network_acl_rule" "private_outbound" {
  for_each = {
    for k, v in var.network_acl_rule_private : k => v if v.type == "outbound"
  }

  name                   = each.key
  enabled                = each.value.enabled
  protocol               = each.value.protocol
  action                 = each.value.action
  ip_version             = each.value.ip_version
  source_ip_address      = each.value.source_ip_address
  source_port            = each.value.source_port
  destination_ip_address = each.value.destination_ip_address
  destination_port       = each.value.destination_port
}

resource "huaweicloud_network_acl_rule" "private_inbound" {
  for_each = {
    for k, v in var.network_acl_rule_private : k => v if v.type == "inbound"
  }

  name                   = each.key
  enabled                = each.value.enabled
  protocol               = each.value.protocol
  action                 = each.value.action
  ip_version             = each.value.ip_version
  source_ip_address      = each.value.source_ip_address
  source_port            = each.value.source_port
  destination_ip_address = each.value.destination_ip_address
  destination_port       = each.value.destination_port
}
