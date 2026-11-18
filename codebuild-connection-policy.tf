
resource "aws_iam_role_policy" "codebuild_connection" {
  name = "terraform-demo-codebuild-connection-policy"
  role = module.iam.codebuild_role_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "codeconnections:GetConnection",
          "codeconnections:GetConnectionToken"
        ]
        Resource = aws_codestarconnections_connection.github.arn
      }
    ]
  })
}
