provider aws {
    region = var.region
}

module vpc {
    source = "../vpc"
    vpc_cidr = "10.0.0.0/16"
    subnet1_cidr = "10.0.1.0/24"
    subnet2_cidr = "10.0.2.0/24"
    subnet3_cidr = "10.0.3.0/24"
    environment = "prod"
    region = var.region
}



variable region {
    default = "us-east-1"
}

module "sg" {
  source = "../sg"
  vpc_id = module.vpc.vpc_id
  port   = [22, 80, 443, 9000]
}
  



module "ec2" {
 source        = "../ec2"
 ami_id        = "ami-0360c520857e3138f"
  instance_type = "t3.micro"
  subnet_id     = module.vpc.public_subnet_ids[0]
  sg_id         = module.sg.sg_id             # pass SG ID from SG module
  key_name      = "ubuntu-key"
}

output "ec2_ip" {
  value = module.ec2.public_ip
}
