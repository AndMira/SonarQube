terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.11.0"
    }
  }
}
  
  
resource "aws_instance" "web" {
  ami                    = var.ami_id
  key_name               = var.key_name
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.sg_id]

}



variable "ami_id" {}
variable "instance_type" {}
variable "subnet_id" {}
variable "sg_id" {}
variable "key_name" {}

output "public_ip" {
  value = aws_instance.web.public_ip
  
}



data "aws_subnet" "subnet" {
  id = var.subnet_id
}



