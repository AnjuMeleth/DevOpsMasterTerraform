provider "aws" {
  region = "ap-south-1"
}
resource "aws_instance" "my-instance" {
  ami                    = "ami-0b44050b2d893d5f7"
  instance_type          = "t2.micro"
  
tags = {
    Name = "ProdServer1"
  }
}


