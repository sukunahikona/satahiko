# VPC
variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}
variable "vpc_name" {
  default = "izanami-vpc-02"
}
variable "public-1a-cidr" {
  default = "10.0.1.0/24"
}
variable "public-1a-name" {
  default = "izanami-public-1a"
}
variable "public-1c-cidr" {
  default = "10.0.2.0/24"
}
variable "public-1c-name" {
  default = "izanami-public-1c"
}
variable "public-1d-cidr" {
  default = "10.0.3.0/24"
}
variable "public-1d-name" {
  default = "izanami-public-1d"
}
variable "private-1a-cidr" {
  default = "10.0.11.0/24"
}
variable "private-1a-name" {
  default = "izanami-private-1a"
}
variable "private-1c-cidr" {
  default = "10.0.12.0/24"
}
variable "private-1c-name" {
  default = "izanami-private-1c"
}
variable "private-1d-cidr" {
  default = "10.0.13.0/24"
}
variable "private-1d-name" {
  default = "izanami-private-1d"
}

# Route
variable "igw-name" {
  default = "izanami-igw"
}
variable "eipa-name" {
  default = "izanami-eipa"
}
variable "eipc-name" {
  default = "izanami-eipc"
}
variable "eipd-name" {
  default = "izanami-eipd"
}
variable "ngwa-name" {
  default = "izanami-ngwa"
}
variable "ngwc-name" {
  default = "izanami-ngwc"
}
variable "ngwd-name" {
  default = "izanami-ngwd"
}
variable "rds-subnet-group-name" {
  default = "izanami-rds-subnet-group"
}

# Security Groups
variable "sg-board-name" {
  default = "izanami-sg-board"
}
variable "sg-alb-name" {
  default = "izanami-sg-alb"
}
variable "sg-ecs-name" {
  default = "izanami-sg-ecs"
}
variable "sg-rds-name" {
  default = "izanami-sg-rds"
}

# Key Pair
variable "key-pair-name" {
  default = "izanami-key-pair"
}

# ACM Certificate
# input variable
# ALBに紐付けるSSL証明書の対象ドメイン名
variable "domain-name" {
  type = string
  description = "input domain"
}
# 上記ドメイン情報を保持するホストゾーンID(Route53)
# 先にRoute53からホストゾーンを開設する必要有り
variable "zone-id" {
  type = string
  description = "input host zone id"
}
variable "certificate-name" {
  default = "izanami-prod-certificate"
}

# LB
variable "alb-name" {
  default = "izanami-alb"
}
variable "alb-tg-name" {
  default = "izanami-alb-tg"
}
variable "dns-domain-name" {
  default = "test-0001.sukunahikona.org"
}

# ECR
variable "ecr-name" {
  default = "izanami-ecr"
}
variable "aws-region" {
  default = "ap-northeast-1"
}
variable "container-name" {
  default = "izanami-container"
}

# ECS
variable "ecs-base-name" {
  default = "izanami-ecs"
}

# RDS
variable "rds-base-name" {
  default = "izanami-rds"
}
variable "db-name" {
  default = "izanami"
}
variable "db-username" {
  default = "izanami"
}
variable "db-password" {
  default = "Hogepiyo"
}
variable "db-snapshot-name" {
  type = string
  description = "input snapshot name"
}