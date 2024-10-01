provider "aws" {
  region     = "ap-south-1"
}
 
 
resource "aws_security_group" "http_access" {
  name        = "http_access"
  description = "SG module"
  vpc_id      = "vpc-0c44112f63ac985c3"
 
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

tags = {
  Name  = "my-sg"
 }
}
 
 
resource "aws_instance" "sg-instance" {
  ami               = "ami-08718895af4dfa033"
  instance_type     = "t2.micro"
  security_groups   = [aws_security_group.http_access.name]
  availability_zone = "ap-south-1a"
  key_name          = "mumbai"
  tags = {
    Name = "Hello"
  }
}
 
 
resource "aws_ebs_volume" "ebsvol" {
  availability_zone = "ap-south-1a"
  size              = 2
 
  tags = {
    Name = "Hello"
  }
}
 
resource "aws_volume_attachment" "this" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebsvol.id
  instance_id = aws_instance.sg-instance.id
}
