
resource "aws_codebuild_project" "main" {
  name          = "${var.project_name}-terraform-ci"
  description   = "Terraform CI validation and plan"
  service_role  = var.service_role_arn
  build_timeout = 20

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "TF_VAR_public_key"
      value = var.public_key
      type  = "PLAINTEXT"
    }
  }

  source {
    type            = "GITHUB"
    location        = var.github_repository_url
    buildspec       = "buildspec.yml"
    git_clone_depth = 1

    auth {
      type     = "CODECONNECTIONS"
      resource = var.github_connection_arn
    }
  }

  tags = {
    Name      = "${var.project_name}-terraform-ci"
    ManagedBy = "Terraform"
  }
}

resource "aws_codebuild_webhook" "main" {
  project_name = aws_codebuild_project.main.name
  build_type   = "BUILD"

  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PUSH"
    }

    filter {
      type    = "HEAD_REF"
      pattern = "^refs/heads/main$"
    }
  }
}


