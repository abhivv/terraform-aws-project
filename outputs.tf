output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "Public subnet ID"
  value       = module.vpc.subnet_id
}

output "security_group_id" {
  description = "Security group ID"
  value       = module.vpc.security_group_id
}

output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = module.vpc.internet_gateway_id
}

output "s3_bucket_id" {
  value = module.s3.bucket_id
}

output "s3_bucket_arn" {
  value = module.s3.bucket_arn
}

output "ec2_instance_id" {
  description = "EC2 instance ID"
  value       = module.ec2.instance_id
}

output "ec2_public_ip" {
  description = "EC2 public IP address"
  value       = module.ec2.public_ip
}

output "ec2_public_dns" {
  description = "EC2 public DNS"
  value       = module.ec2.public_dns
}

output "codebuild_role_arn" {
  value = module.iam.codebuild_role_arn
}

output "codebuild_role_name" {
  value = module.iam.codebuild_role_name
}


output "github_connection_arn" {
  description = "GitHub connection ARN"
  value       = aws_codestarconnections_connection.github.arn
}

output "codebuild_project_name" {
  value = module.codebuild.project_name
}

output "codebuild_project_arn" {
  value = module.codebuild.project_arn
}