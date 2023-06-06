variable "project" {
  type        = string
  description = "The name of the Project"
}

variable "aws_account_id" {
  type        = string
  description = "The AWS Account ID"
}

variable "region" {
  type        = string
  description = "The AWS Region"
}

variable "availability_zones" {
  type        = list(string)
  description = "The AWS AZs to use"
}

variable "environment" {
  type        = string
  description = "The name of the environment"
}

variable "terraform_state_bucket" {
  type        = string
  description = "The name of the remote state bucket (used by tfscaffold itself)"
}

variable "cidr_block" {
  type        = string
  description = "The CIDR block of the main VPC"
}

variable "frontend_network_blocks" {
  type        = list(number)
  description = "The third tuple of network blocks to use"
}

variable "backend_network_blocks" {
  type        = list(number)
  description = "The third tuple of network blocks to use"
}
