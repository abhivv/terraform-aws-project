
output "codebuild_role_arn" {
  description = "CodeBuild IAM role ARN"
  value       = aws_iam_role.codebuild.arn
}

output "codebuild_role_name" {
  description = "CodeBuild IAM role name"
  value       = aws_iam_role.codebuild.name
}
