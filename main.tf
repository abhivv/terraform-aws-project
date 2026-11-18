# CI/CD pipeline test

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
  public_key        = var.public_key
}

module "s3" {
  source = "./modules/s3"

  project_name = var.project_name
  bucket_name  = var.bucket_name
}

module "iam" {
  source = "./modules/iam"

  project_name   = var.project_name
  aws_region     = var.aws_region
  aws_account_id = "089603615347"
}


resource "aws_codestarconnections_connection" "github" {
  name          = "terraform-demo-github"
  provider_type = "GitHub"

  tags = {
    Name      = "terraform-demo-github"
    ManagedBy = "Terraform"
  }
}

module "codebuild" {
  source = "./modules/codebuild"

  project_name          = var.project_name
  service_role_arn      = module.iam.codebuild_role_arn
  github_connection_arn = aws_codestarconnections_connection.github.arn
  public_key            = var.public_key
  github_repository_url = "https://github.com/abhivv/terraform-aws-project.git"
  allowed_ssh_cidr      = var.allowed_ssh_cidr
  aws_region            = var.aws_region
  depends_on = [
    aws_iam_role_policy.codebuild_connection
  ]
}
