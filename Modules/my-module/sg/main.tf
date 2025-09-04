


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.11.0"
    }
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = var.port[0]
    to_port     = var.port[0]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


ingress {
    description = "TLS from VPC"
    from_port   = var.port[1]
    to_port     = var.port[1]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    from_port   = var.port[2]
    to_port     = var.port[2]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


   ingress {
    description = "TLS from VPC"
    from_port   = var.port[3]
    to_port     = var.port[3]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
    
  }


  variable port {
   type = list(number)
  description = "Provide port"
}
output "sg_id" {
  value = aws_security_group.allow_tls.id
}

variable "vpc_id" {
  description = "VPC ID where the security group will be created"
  type        = string
}


