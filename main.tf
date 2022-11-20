locals {
    common_tags = {
    Environment = var.env
  }
}

provider "aws" {
  region     = var.aws_region
  default_tags {
    tags = merge(local.common_tags)
  }
}


locals {
  availability_zone = "${var.aws_region}${var.availability_zone}"
}

locals {
  public_subnet_cidr  = cidrsubnet(var.vpc_cidr_security, var.subnet_bits, var.public_subnet_index)
}
locals {
  private_subnet_cidr = cidrsubnet(var.vpc_cidr_security, var.subnet_bits, var.private_subnet_index)
}

module "vpc" {
  source = "git::https://github.com/40netse/terraform-modules.git//aws_vpc"

  vpc_name                   = "${var.cp}-${var.env}-${var.vpc_name_security}-vpc"
  vpc_cidr                   = var.vpc_cidr_security
}

resource "aws_default_route_table" "route_public" {
  default_route_table_id = module.vpc.vpc_main_route_table_id
  tags = {
    Name = "default route table for vpc (unused)"
  }
}


module "igw" {
  source = "git::https://github.com/40netse/terraform-modules.git//aws_igw"

  igw_name                   = "${var.cp}-${var.env}-igw"
  vpc_id                     = module.vpc.vpc_id
}

module "public-subnet" {
  source = "git::https://github.com/40netse/terraform-modules.git//aws_subnet"
  subnet_name = "${var.cp}-${var.env}-${var.public_description}-subnet"

  vpc_id                     = module.vpc.vpc_id
  availability_zone          = local.availability_zone
  subnet_cidr                = local.public_subnet_cidr
  public_route               = 1
  public_route_table_id      = module.public_route_table.id
}

module "private-subnet" {
  source = "git::https://github.com/40netse/terraform-modules.git//aws_subnet"
  subnet_name = "${var.cp}-${var.env}-${var.private_description}-subnet"

  vpc_id            = module.vpc.vpc_id
  availability_zone = local.availability_zone
  subnet_cidr       = local.private_subnet_cidr
}


module "public_route_table" {
  source  = "git::https://github.com/40netse/terraform-modules.git//aws_route_table"
  rt_name = "${var.cp}-${var.env}-public-rt"

  vpc_id                     = module.vpc.vpc_id
  gateway_route              = 1
  igw_id                     = module.igw.igw_id
}

module "private_route_table" {
  source  = "git::https://github.com/40netse/terraform-modules.git//aws_route_table"
  rt_name = "${var.cp}-${var.env}-${var.private_description}-rt"

  vpc_id                     = module.vpc.vpc_id
}



module "private_route_table_association" {
  source   = "git::https://github.com/40netse/terraform-modules.git//aws_route_table_association"

  subnet_ids                 = module.private-subnet.id
  route_table_id             = module.private_route_table.id
}
