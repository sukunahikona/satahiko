# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = var.vpc_id

  tags = {
    Name = var.igw-name
  }
}

# Elasti IP
resource "aws_eip" "nat_1a" {
  #vpc = true
  tags = {
    Name = var.eipa-name
  }
}
resource "aws_eip" "nat_1c" {
  #vpc = true
  tags = {
    Name = var.eipc-name
  }
}
resource "aws_eip" "nat_1d" {
  #vpc = true
  tags = {
    Name = var.eipd-name
  }
}

# NAT Gateway
resource "aws_nat_gateway" "nat_1a" {
  subnet_id     = var.aws_subnet_public_1a # Subnet
  allocation_id = aws_eip.nat_1a.id        # Elastic IP

  tags = {
    Name = var.ngwa-name
  }
}
resource "aws_nat_gateway" "nat_1c" {
  subnet_id     = var.aws_subnet_public_1c
  allocation_id = aws_eip.nat_1c.id

  tags = {
    Name = var.ngwc-name
  }
}
resource "aws_nat_gateway" "nat_1d" {
  subnet_id     = var.aws_subnet_public_1d
  allocation_id = aws_eip.nat_1d.id

  tags = {
    Name = var.ngwd-name
  }
}

# Route Table
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  tags = {
    Name = "public-route-table"
  }
}

# Route
resource "aws_route" "public" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.main.id
}

# Association
resource "aws_route_table_association" "public_1a" {
  subnet_id      = var.aws_subnet_public_1a
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_1c" {
  subnet_id      = var.aws_subnet_public_1c
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_1d" {
  subnet_id      = var.aws_subnet_public_1d
  route_table_id = aws_route_table.public.id
}

# Route Table (Private)
resource "aws_route_table" "private_1a" {
  vpc_id = var.vpc_id

  tags = {
    Name = "private-1a-route-table"
  }
}
resource "aws_route_table" "private_1c" {
  vpc_id = var.vpc_id

  tags = {
    Name = "private-1c-route-table"
  }
}
resource "aws_route_table" "private_1d" {
  vpc_id = var.vpc_id

  tags = {
    Name = "private-1d-route-table"
  }
}

# Route (Private)
resource "aws_route" "private_1a" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.private_1a.id
  nat_gateway_id         = aws_nat_gateway.nat_1a.id
}
resource "aws_route" "private_1c" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.private_1c.id
  nat_gateway_id         = aws_nat_gateway.nat_1c.id
}
resource "aws_route" "private_1d" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.private_1d.id
  nat_gateway_id         = aws_nat_gateway.nat_1d.id
}

# Association (Private)
resource "aws_route_table_association" "private_1a" {
  subnet_id      = var.aws_subnet_private_1a
  route_table_id = aws_route_table.private_1a.id
}
resource "aws_route_table_association" "private_1c" {
  subnet_id      = var.aws_subnet_private_1c
  route_table_id = aws_route_table.private_1c.id
}
resource "aws_route_table_association" "private_1d" {
  subnet_id      = var.aws_subnet_private_1d
  route_table_id = aws_route_table.private_1d.id
}
