resource "aws_key_pair" "github_runner" {
  key_name   = "github-runner-key"
  public_key = file(var.public_key_path)
}

resource "aws_security_group" "runner_sg" {
  name        = "github-runner-sg"
  description = "Allow SSH"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.runner_sg_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "github_runner" {
  ami           = var.ami_id
  instance_type = "t3.medium"
  key_name      = aws_key_pair.github_runner.key_name
  subnet_id     = module.vpc.public_subnets[0]
  security_groups = [
    aws_security_group.runner_sg.id
  ]

  tags = {
    Name = "github-actions-runner"
  }
}
