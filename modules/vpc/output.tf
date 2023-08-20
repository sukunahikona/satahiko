output "vpc_id" {
  value = aws_vpc.main.id
}

output "aws_subnet_public_1a" {
  value = aws_subnet.public_1a.id
}

output "aws_subnet_public_1c" {
  value = aws_subnet.public_1c.id
}

output "aws_subnet_public_1d" {
  value = aws_subnet.public_1d.id
}

output "aws_subnet_private_1a" {
  value = aws_subnet.private_1a.id
}

output "aws_subnet_private_1c" {
  value = aws_subnet.private_1c.id
}

output "aws_subnet_private_1d" {
  value = aws_subnet.private_1d.id
}
