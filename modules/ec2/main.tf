resource "aws_key_pair" "main" {
  key_name   = "${var.project_name}-key"
  public_key = file("${path.root}/keys/terraform-demo-key.pub")

  tags = {
    Name = "${var.project_name}-key"
  }
}

resource "aws_instance" "main" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = aws_key_pair.main.key_name
  associate_public_ip_address = true

  root_block_device {
    volume_size           = 8
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name = "${var.project_name}-ec2"
  }
}