
variable "aws_region" {
  description = "The AWS region to use"
}
variable "customer_prefix" {
  description = "Customer Prefix to apply to all resources"
}
variable "environment" {
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
}
variable "public_subnet_index" {
  description = "Index of the public subnet"
}
variable "private_subnet_index" {
  description = "Index of the private subnet"
}
variable "public_description" {
    description = "Description Public Subnet TAG"
}
variable "private_description" {
    description = "Description Private Subnet TAG"
}
variable "vpc_tag_key" {
    description = "Random Tag Key to place on VPC for data ID"
    default     = ""
}
variable "vpc_tag_value" {
    description = "Random Tag Value to place on VPC for data ID"
    default     = ""
}

