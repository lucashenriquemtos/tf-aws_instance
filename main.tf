provider "aws" {
  version = "~> 4.0"
  region  = "sa-east-1"
}

resource "aws_instance" "dev" {
  count = 3
  ami = "ami-0a9e90bd830396d02"
  instance_type = "t2.micro"
  key_name = "terraform-aws"
  tags = {
    Name = "tf-dev-instance-${count.index}"
  }
  vpc_security_group_ids = ["sg-035db0b26624d4ab0"]
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["191.193.58.163/32"]
  }

  tags = {
    Name = "allow_ssh"
  }
}