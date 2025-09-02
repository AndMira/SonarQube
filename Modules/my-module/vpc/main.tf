resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
  Name = "${var.environment}-vpc"
}

}

resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet1_cidr
  map_public_ip_on_launch = var.ip_on_launch
  availability_zone       = "${var.region}a"

  tags = {
    Name = "${var.environment}-subnet1"
  }
}

resource "aws_subnet" "main2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet2_cidr
  map_public_ip_on_launch = var.ip_on_launch
  availability_zone       = "${var.region}b"

  tags = {
    Name = "${var.environment}-subnet2"
  }
}

resource "aws_subnet" "main3" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet3_cidr
  map_public_ip_on_launch = var.ip_on_launch
  availability_zone       = "${var.region}c"

  tags = {
    Name = "${var.environment}-subnet3"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.environment}-IGW"
  }
}

resource "aws_route_table" "example" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.environment}-RT"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.example.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.main2.id
  route_table_id = aws_route_table.example.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.main3.id
  route_table_id = aws_route_table.example.id
}


variable "region" {}
variable "vpc_cidr" {}
variable "subnet1_cidr" {}
variable "subnet2_cidr" {}
variable "subnet3_cidr" {}
variable environment {}
variable "ip_on_launch" {
  type    = bool
  default = true
}




output "public_subnet_ids" {
  value = [
    aws_subnet.main.id,
    aws_subnet.main2.id,
    aws_subnet.main3.id
  ]
}

output "vpc_id" {
  value = aws_vpc.main.id
}
