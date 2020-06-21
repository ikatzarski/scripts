provider "aws" {
  region = "eu-west-2"
}

resource "aws_key_pair" "ansible_host_key" {
  key_name   = "ansible-host-key"
  public_key = file("~/.ssh/ansible-host.pub")
}

resource "aws_instance" "ubuntu_host_1" {
  ami           = "ami-082bcf37bf94b4417"
  instance_type = "t2.micro"
  key_name      = "ansible-host-key"

  tags = {
    Name = "ansible-ubuntu-host-1"
  }
}

resource "aws_instance" "ubuntu_host_2" {
  ami           = "ami-082bcf37bf94b4417"
  instance_type = "t2.micro"
  key_name      = "ansible-host-key"

  tags = {
    Name = "ansible-ubuntu-host-2"
  }
}

output "host1_public_dns" {
  value       = aws_instance.ubuntu_host_1.public_dns
  description = "Host1's public DNS"
}

output "host2_public_dns" {
  value       = aws_instance.ubuntu_host_2.public_dns
  description = "Host2's public DNS"
}
