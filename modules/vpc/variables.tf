
variable "project_name" {
  description = "demo-poc25"
  type        = string
}

variable "vpc_cidr" {
  description = "10.0.0.0/16"
  type        = string
}

variable "public_subnet_cidr" {
  description = "10.0.1.0/24"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "49.37.128.120/32"
  type        = string
}
