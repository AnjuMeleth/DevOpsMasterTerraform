provider "aws" {
  region = "ap-south-1"
}
resource "aws_instance" "my-instance" {
  ami                    = "ami-0b44050b2d893d5f7"
  instance_type          = "t2.micro"
  key_name 		 = "JenkinsMumbai"
  vpc_security_group_ids = [aws_security_group.secGrp1.id] 
user_data = <<-EOF
		#! /bin/bash
                sudo apt-get update
		sudo apt-get install -y docker.io
		sudo docker run -d -p 50000:50000 -p 8080:8080 anjurose/jenkins
		EOF  
tags = {
    Name = "ProdServer3"
  }
}
resource "aws_security_group" "secGrp1" {

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 50000
    to_port     = 50000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]	
    }	
}
