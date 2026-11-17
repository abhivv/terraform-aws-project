module "vpc" {
  source = "./modules/vpc"

  project_name       = var.project_name
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  allowed_ssh_cidr   = var.allowed_ssh_cidr
}

module "ec2" {
  source = "./modules/ec2"

  project_name      = var.project_name
  ami_id            = "ami-0e9262cbb2344d5ee"
  instance_type     = var.instance_type
  subnet_id         = module.vpc.subnet_id
  security_group_id = module.vpc.security_group_id
}

module "s3" {
  source = "./modules/s3"

  project_name = var.project_name
  bucket_name  = var.bucket_name
}