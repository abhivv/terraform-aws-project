
resource "aws_iam_role" "codebuild" {
  name = "${var.project_name}-codebuild-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "codebuild.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name      = "${var.project_name}-codebuild-role"
    ManagedBy = "Terraform"
  }
}

resource "aws_iam_role_policy" "codebuild" {
  name = "${var.project_name}-codebuild-policy"
  role = aws_iam_role.codebuild.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      # CloudWatch Logs
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      },

      # Terraform remote state in S3
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket",
          "s3:GetBucketLocation"
        ]
        Resource = [
          "arn:aws:s3:::abhi-d2-terraform-state-089603615347",
          "arn:aws:s3:::abhi-d2-terraform-state-089603615347/*"
        ]
      },

      # Terraform state locking in DynamoDB
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem",
          "dynamodb:DescribeTable"
        ]
        Resource = "arn:aws:dynamodb:${var.aws_region}:${var.aws_account_id}:table/terraform-state-locks"
      },

      # EC2 read permissions
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeInstanceTypes",
          "ec2:DescribeTags",
          "ec2:DescribeKeyPairs",
          "ec2:DescribeVpcs",
          "ec2:DescribeVpcAttribute",
          "ec2:DescribeSubnets",
          "ec2:DescribeInternetGateways",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeRouteTables"
        ]
        Resource = "*"
      },

      # IAM read permissions
      {
        Effect = "Allow"
        Action = [
          "iam:GetRole",
          "iam:ListRolePolicies",
          "iam:GetRolePolicy",
          "iam:ListAttachedRolePolicies"
        ]
        Resource = "arn:aws:iam::${var.aws_account_id}:role/${var.project_name}-codebuild-role"
      },

      # S3 application bucket configuration reads
      {
        Effect = "Allow"
        Action = [
          "s3:GetBucketVersioning",
          "s3:GetEncryptionConfiguration",
          "s3:GetBucketPublicAccessBlock"
        ]
        Resource = "arn:aws:s3:::${var.project_name}-app-${var.aws_account_id}"
      },

      # CodeConnections read permission
      {
        Effect = "Allow"
        Action = [
          "codeconnections:ListTagsForResource"
        ]
        Resource = "arn:aws:codestar-connections:${var.aws_region}:${var.aws_account_id}:connection/7548af9c-61d8-4078-bbbe-e029a5cee6f4"
      },

      # CodeBuild read permission
      {
        Effect = "Allow"
        Action = [
          "codebuild:BatchGetProjects"
        ]
        Resource = "arn:aws:codebuild:${var.aws_region}:${var.aws_account_id}:project/${var.project_name}-terraform-ci"
      }
    ]
  })
}
