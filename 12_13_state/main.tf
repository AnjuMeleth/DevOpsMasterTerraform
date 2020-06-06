provider "aws" {
  region = "ap-south-1"
}
resource "aws_instance" "my-instance" {
  ami                    = "ami-0b44050b2d893d5f7"
  instance_type          = "t2.micro"
  key_name 		 = "JenkinsMumbai"
  vpc_security_group_ids = [aws_security_group.secGrp1.id] 
  
user_data = <<-EOF
              #!/bin/bash
	      sudo apt-get update	
	      sudo apt-get install -y apache2
	      sudo service apache2 start  	
	      EOF
tags = {
    Name = "ProdServer2"
  }
}
resource "aws_security_group" "secGrp1" {

  ingress {
    from_port   = 80
    to_port     = 80
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
resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraformupandrunningstate"
  force_destroy = true
  # Prevent accidental deletion of this S3 bucket
  lifecycle {
   prevent_destroy = true
  }

  # Enable versioning so we can see the full revision history of our
  # state files
  versioning {
    enabled = true
  }

  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
