output "vpc_id" {
  description = "The VPC ID in UUID format"
  value       = huaweicloud_vpc.main.id
}

output "vpc_status" {
  description = "The current status of the VPC"
  value       = huaweicloud_vpc.main.status
}

output "vpc_cidr" {
  description = "The CIDR of the VPC"
  value       = huaweicloud_vpc.main.cidr
}

output "private_subnets_ids" {
  description = "List of IDs of Private Subnets in UUID format"
  value       = huaweicloud_vpc_subnet.private.*.id
}

output "private_subnets_subnet_ids" {
  description = "List of IDs of the IPv4 subnet (Native OpenStack API)"
  value       = huaweicloud_vpc_subnet.private.*.subnet_id
}

output "public_subnets_ids" {
  description = "List of IDs of Public Subnets in UUID format"
  value       = huaweicloud_vpc_subnet.public.*.id
}

output "public_subnets_subnet_ids" {
  description = "List of IDs of the IPv4 subnet (Native OpenStack API)"
  value       = huaweicloud_vpc_subnet.public.*.subnet_id
}
