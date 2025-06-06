provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "balaterraformbucket"
    key    = "albtest.tfstate"
    region = "us-east-1"
  }
}

resource "aws_vpc" "ALB_VPC" {
  cidr_block           = var.VPC_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.VPC_Name
  }
}

resource "aws_internet_gateway" "ALB_IGW" {
  vpc_id = aws_vpc.ALB_VPC.id

  tags = {
    Name = "${var.VPC_Name}-IGW"
  }
}

resource "aws_subnet" "ALB_VPC_Public_Subnet" {
  count                   = length(var.ALB_VPC_Public_Subnet)
  vpc_id                  = aws_vpc.ALB_VPC.id
  cidr_block              = element(var.ALB_VPC_Public_Subnet, count.index)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.VPC_Name}-Public-Subnet-${count.index+1}"
  }
}

resource "aws_subnet" "ALB_VPC_Private_Subnet" {
  count                   = length(var.ALB_VPC_Private_Subnet)
  vpc_id                  = aws_vpc.ALB_VPC.id
  cidr_block              = element(var.ALB_VPC_Private_Subnet, count.index)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.VPC_Name}-Private-Subnet-${count.index+1}"
  }
}

resource "aws_eip" "ALB_VPC_NAT_EIP" {
  domain = "vpc"

  tags = {
    Name = "${var.VPC_Name}-NAT-EIP"
  }
}

resource "aws_nat_gateway" "ALB_VPC_NAT_GW" {
  allocation_id = aws_eip.ALB_VPC_NAT_EIP.id
  subnet_id = aws_subnet.ALB_VPC_Public_Subnet[0].id
  depends_on = [aws_internet_gateway.ALB_IGW]

  tags = {
    Name = "${var.VPC_Name}-NAT-GW"
  }
}

resource "aws_route_table" "ALB_VPC_Public_RT" {
  vpc_id = aws_vpc.ALB_VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ALB_IGW.id
  }

  tags = {
    Name = "${var.VPC_Name}-Public-RT"
  }
}

resource "aws_route_table" "RDS-VPC-Private-RT" {
  vpc_id = aws_vpc.ALB_VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ALB_VPC_NAT_GW.id
  }

  tags = {
    Name = "${var.VPC_Name}-Private-RT"
  }
}

resource "aws_route_table_association" "ALB_VPC_Public_RT_Association" {
  count = length(var.ALB_VPC_Public_Subnet)
  subnet_id = element(aws_subnet.ALB_VPC_Public_Subnet.*.id, count.index)
  route_table_id = aws_route_table.ALB_VPC_Public_RT.id
}

resource "aws_route_table_association" "ALB_VPC_Private_RT_Association" {
  count = length(var.ALB_VPC_Private_Subnet)
  subnet_id = element(aws_subnet.ALB_VPC_Private_Subnet.*.id, count.index)
  route_table_id = aws_route_table.RDS-VPC-Private-RT.id
}

resource "aws_security_group" "ALB_VPC_SG" {
  name = var.ALB_VPC_SG
  description = "Allow required inbound and outbound traffic for ALB"
  vpc_id = aws_vpc.ALB_VPC.id

  ingress {
    description = "Allow HTTP"
    protocol = "tcp"
    from_port = 80
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow HTTPS"
    protocol = "tcp"
    from_port = 443
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow SSH"
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.VPC_Name}-SG"
  }
}