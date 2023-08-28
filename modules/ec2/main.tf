# AMI
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images-testing/hvm-ssd/ubuntu-jammy-daily-amd64-server-*"]
  }
}

# ec2
resource "aws_instance" "main" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.nano"
  availability_zone           = "ap-northeast-1a"
  vpc_security_group_ids      = [var.sg_board_id]
  subnet_id                   = var.aws_subnet_public_1a
  associate_public_ip_address = "true"
  key_name                    = var.key_pair_main_id
  user_data                   = file("${path.module}/script.sh")
  tags = {
    Name = "izanami-ec2-board"
  }
}
