
# Create a VPC
resource "aws_vpc" "vpc-id" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc-id"
  }
}
resource "aws_subnet" "public-sub-1" {
  vpc_id     = aws_vpc.vpc-id.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "public-sub-1"
  }
}
resource "aws_subnet" "public-sub-2" {
  vpc_id     = aws_vpc.vpc-id.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "public-sub-2"
  }
}

#INTERNET GATEWAY
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc-id.id

  tags = {
    Name = "vpc-id"
  }
}
#route table
resource "aws_route_table" "public-rt-1" {
  vpc_id = aws_vpc.vpc-id.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }


  tags = {
    Name = "public-rt-1"
  }
}
resource "aws_route_table" "public-rt-2" {
  vpc_id = aws_vpc.vpc-id.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }


  tags = {
    Name = "public-rt-2"
  }
}

# rt associate
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public-sub-1.id
  route_table_id = aws_route_table.public-rt-1.id
}
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.public-sub-2.id
  route_table_id = aws_route_table.public-rt-2.id
}

# SECURITY GROUP
resource "aws_security_group" "all" {
  name        = "all"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc-id.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
 
  }

  tags = {
    Name = "all"
  }
}

# INSTANCE
resource "aws_instance" "public-1" {
  ami                           = var.os
  instance_type                 = var.size
  subnet_id                     = aws_subnet.public-sub-1.id
  vpc_security_group_ids        = [aws_security_group.all.id]
  key_name                      = var.key
  associate_public_ip_address   = true
  tags                          = var.ec2-tags
}
resource "aws_instance" "public-2" {
  ami                           = var.os
  instance_type                 = var.size
  subnet_id                     = aws_subnet.public-sub-2.id
  vpc_security_group_ids        = [aws_security_group.all.id]
  key_name                      = var.key 
  associate_public_ip_address   = true
  tags                          = var.ec2-tags1
}