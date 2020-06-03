provider "aws" {
  region = "ap-south-1"
}
resource "aws_instance" "my-instance" {
  ami                    = "ami-0b44050b2d893d5f7"
  instance_type          = "t2.micro"
  key_name 		 = "JenkinsMumbai"
  vpc_security_group_ids = [aws_security_group.secGrp1.id] 
tags = {
    Name = "ProdServer1"
  }
}
resource "aws_security_group" "secGrp1" {

  ingress {
    from_port   = 22 
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
