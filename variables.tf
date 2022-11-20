
variable "aws_region" {
  description = "The AWS region to use"
}
variable "cp" {
  description = "Customer Prefix to apply to all resources"
}
variable "env" {
  description = "The Tag Environment to differentiate prod/test/dev"
}
variable "availability_zone" {
  description = "Availability Zone for VPC"
}
variable "vpc_name_security" {
  description = "VPC Name"
}
variable "vpc_cidr_security" {
    description = "CIDR for the whole VPC"
}
variable subnet_bits {
  description = "Number of bits in the network portion of the subnet CIDR"
  default = 8
}
variable "public_subnet_index" {
  description = "Index of the public subnet"
  default = 0
}
variable "private_subnet_index" {
  description = "Index of the private subnet"
  default = 1
}
variable "public_description" {
    description = "Description Public Subnet TAG"
}
variable "private_description" {
    description = "Description Private Subnet TAG"
}


