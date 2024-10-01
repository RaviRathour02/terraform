resource "aws_vpc" "VPC-NEW" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
 
  tags = {
    Name = "VPC-NEW"
  }
}
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.VPC-NEW.id
  availability_zone = "ap-south-1a"
  cidr_block        = "10.0.0.0/24"
 
  tags = {
    Name = "public"
  }
}
 
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.VPC-NEW.id
  availability_zone = "ap-south-1b"
  cidr_block        = "10.0.1.0/24"
 
  tags = {
    Name = "private"
  }
}
 
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.VPC-NEW.id
 
  tags = {
    Name = "main"
  }
}
 
resource "aws_eip" "nat" {
  domain = "vpc"
  tags = {
    Name = "nat"
  }
}
 
resource "aws_nat_gateway" "new-nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id
 
  tags = {
    Name = "new-nat"
  }
}
 
resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.VPC-NEW.id
 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
 
  }
 
  tags = {
    Name = "public-route"
  }
} 
resource "aws_route_table_association" "pub-rt-assc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public-route.id
}

resource "aws_route_table" "private-route" {
  vpc_id = aws_vpc.VPC-NEW.id
 
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.new-nat.id
 
  }
 
  tags = {
    Name = "private-route"
  }
}
resource "aws_route_table_association" "pri-rt-assc" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private-route.id
}
 
