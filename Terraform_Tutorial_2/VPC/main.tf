resource "aws_vpc" "main" {
  cidr_block           = var.vpc-cidr-block
  enable_dns_hostnames = true
  
  tags = {
      name = "main-vpc"
  }
  

}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "publicA" {
  cidr_block        = var.pub-snA-cidr-block
  availability_zone = data.aws_availability_zones.available.names[0]
  vpc_id            = aws_vpc.main.id
}

resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "VPC Internet Gateway"
  }

}

resource "aws_route_table" "vpc_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_igw.id
  }

  tags = {
    Name = "Route Table for VPC"
  }
}

resource "aws_route_table_association" "pub_subA_rta" {
  subnet_id      = aws_subnet.publicA.id
  route_table_id = aws_route_table.vpc_rt.id
}