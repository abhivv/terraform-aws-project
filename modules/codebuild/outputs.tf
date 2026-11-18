
output "project_name" {
  value = aws_codebuild_project.main.name
}

output "project_arn" {
  value = aws_codebuild_project.main.arn
}

output "webhook_url" {
  value = aws_codebuild_webhook.main.url
}
