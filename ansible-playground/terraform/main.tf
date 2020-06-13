provider "aws" {
  region = "eu-west-2"
}

resource "aws_key_pair" "ansible_slave_key" {
  key_name   = "ansible-slave-key"
  public_key = file("~/.ssh/ansible-slave.pub")
}

resource "aws_instance" "ubuntu_slave_1" {
  ami           = "ami-082bcf37bf94b4417"
  instance_type = "t2.micro"
  key_name      = "ansible-slave-key"

  tags = {
    Name = "ansible-ubuntu-slave-1"
  }
}

resource "aws_instance" "ubuntu_slave_2" {
  ami           = "ami-082bcf37bf94b4417"
  instance_type = "t2.micro"
  key_name      = "ansible-slave-key"

  tags = {
    Name = "ansible-ubuntu-slave-2"
  }
}

output "slave1_public_dns" {
  value       = aws_instance.ubuntu_slave_1.public_dns
  description = "Slave1's public DNS"
}

output "slave2_public_dns" {
  value       = aws_instance.ubuntu_slave_2.public_dns
  description = "Slave2's public DNS"
}
