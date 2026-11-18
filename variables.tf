
variable "aws_region" {
  description = "AWS deployment region"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "terraform-demo"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "Public subnet CIDR"
  type        = string
  default     = "10.0.1.0/24"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "allowed_ssh_cidr" {
  description = "Your public IP address in CIDR notation"
  type        = string
}

variable "bucket_name" {
  description = "Application S3 bucket name"
  type        = string
  default     = "terraform-demo-app-089603615347"
}

variable "public_key" {
  description = "SSH public key for EC2 access"
  type        = string
  sensitive   = true
}
