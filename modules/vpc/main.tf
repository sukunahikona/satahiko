resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = var.vpc_name
  }
}

# Public Subnets
# AZ 1a
resource "aws_subnet" "public_1a" {
  vpc_id = aws_vpc.main.id

  availability_zone = "ap-northeast-1a"

  cidr_block = var.public-1a-cidr

  tags = {
    Name = var.public-1a-name
  }
}

# AZ 1c
resource "aws_subnet" "public_1c" {
  vpc_id = aws_vpc.main.id

  availability_zone = "ap-northeast-1c"

  cidr_block = var.public-1c-cidr

  tags = {
    Name = var.public-1c-name
  }
}

# AZ 1d
resource "aws_subnet" "public_1d" {
  vpc_id = aws_vpc.main.id

  availability_zone = "ap-northeast-1d"

  cidr_block = var.public-1d-cidr

  tags = {
    Name = var.public-1d-name
  }
}

# Private Subnets
resource "aws_subnet" "private_1a" {
  vpc_id = aws_vpc.main.id

  availability_zone = "ap-northeast-1a"
  cidr_block        = var.private-1a-cidr

  tags = {
    Name = var.private-1a-name
  }
}

resource "aws_subnet" "private_1c" {
  vpc_id = aws_vpc.main.id

  availability_zone = "ap-northeast-1c"
  cidr_block        = var.private-1c-cidr

  tags = {
    Name = var.private-1c-name
  }
}

resource "aws_subnet" "private_1d" {
  vpc_id = aws_vpc.main.id

  availability_zone = "ap-northeast-1d"
  cidr_block        = var.private-1d-cidr

  tags = {
    Name = var.private-1d-name
  }
}
