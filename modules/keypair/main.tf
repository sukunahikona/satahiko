# Algorithm
resource "tls_private_key" "main" {
    algorithm = "RSA"
    rsa_bits = 4096
}

# Key Pair
resource "aws_key_pair" "main" {
  key_name   = var.key-pair-name
  public_key = tls_private_key.main.public_key_openssh

  tags = {
    Name = var.key-pair-name
  }
}

# File Output
resource "local_sensitive_file" "keypair_pem" {
    filename = "${path.module}/${var.key-pair-name}.pem"
    content = tls_private_key.main.private_key_pem
    file_permission = "0600" # add execute permission
}

resource "local_sensitive_file" "keypair_pub" {
    filename = "${path.module}/${var.key-pair-name}.pub"
    content = tls_private_key.main.public_key_openssh
}
