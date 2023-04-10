provider "huaweicloud" {
  region = "ap-southeast-3"
}

module "vpc" {
  source  = "cloud-labs-infra/vpc/huaweicloud"
  version = "1.0.0"

  name               = "dev01"
  region             = "ap-southeast-3"
  availability_zones = ["ap-southeast-3a", "ap-southeast-3c"]
  cidr               = "10.0.240.0/20"
  subnets = {
    public  = ["10.0.240.0/22", "10.0.244.0/22"]
    private = ["10.0.248.0/22", "10.0.252.0/22"]
  }
  private_to_internet = false
  primary_dns         = "100.125.1.250"
  secondary_dns       = "100.125.128.250"

  nat_snat_floating_ip_ids = [
    module.eip.id
  ]

  tags = {
    "Env" : "dev01"
  }
}

module "eip" {
  source  = "cloud-labs-infra/eip/huaweicloud"
  version = "1.0.0"

  name         = "dev01"
  name_postfix = "gw-snat"
}
