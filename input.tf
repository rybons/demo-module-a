# Provider variables

variable "aws_region" {
  description = "The region the infrastructure is deployed to"
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "The aws profile (credential set) used by terraform"
  default     = "default"
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  default = "10.0.1.0/24"
}
