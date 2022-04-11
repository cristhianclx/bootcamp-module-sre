resource "aws_default_vpc" "main" {
  tags = {
    Name = "vpc"
  }
}

resource "aws_default_subnet" "main_1a" {
  availability_zone = "us-east-1a"
  tags = {
    Name = "vpc-1a"
  }
}
resource "aws_default_subnet" "main_1b" {
  availability_zone = "us-east-1b"
  tags = {
    Name = "vpc-1b"
  }
}
resource "aws_default_subnet" "main_1c" {
  availability_zone = "us-east-1c"
  tags = {
    Name = "vpc-1c"
  }
}
