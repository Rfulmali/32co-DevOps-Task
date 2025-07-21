variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "main"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "private_subnets" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.0.0/19", "10.0.32.0/19"]
}

variable "public_subnets" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.64.0/19", "10.0.96.0/19"]
}

variable "cluster_name" {
  description = "Name of the Cluster"
  type        = string
  default     = "main"
}

variable "region" {
  default = "us-east-1"
}

variable "ami_id" {
  description = "Amazon Linux 2 AMI or Ubuntu"
  default     = "ami-0abcdef1234567890"
}

variable "public_key_path" {
  description = "Path to your SSH public key"
  default     = "~/.ssh/32co-task-key.pub"
}

variable "runner_sg_cidr" {
  description = "Your IP CIDR for SSH access"
  default     = "0.0.0.0/0"
}

variable "ecr_repo_name" {
  description = "ECR Repo Name"
  default = "nodejs-crud-api"
}