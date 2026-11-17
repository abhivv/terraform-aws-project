
terraform {
  backend "s3" {
    bucket         = "abhi-d2-terraform-state-089603615347"
    key            = "terraform-aws-project/terraform.tfstate"
    region         = "ap-southeast-2"
    encrypt        = true
    dynamodb_table = "terraform-state-locks"
  }
}
