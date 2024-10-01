resource "aws_security_group" "http_access" {
  name        = "http_access"
  description = "SG module"
  vpc_id      = "vpc-078ff2277e559d3c9"
 
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
 
}
 
 
resource "aws_instance" "sg-instance" {
  ami               = "ami-0aa097a5c0d31430a"
  instance_type     = "t2.micro"
  security_groups   = [aws_security_group.http_access.name]
  availability_zone = "ap-southeast-1a"
  key_name          = "new-azure"
  tags = {
    Name = "Hello"
  }
}
