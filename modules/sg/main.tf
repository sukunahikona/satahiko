# Security Group作成
# BOARD
resource "aws_security_group" "sg_board" {
  name        = var.sg-board-name
  description = "For EC2 Linux"
  vpc_id      = var.vpc_id
  tags = {
    Name = var.sg-board-name
  }

  # インバウンドルール
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # アウトバウンドルール
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# ALB
resource "aws_security_group" "sg_alb" {
  name        = var.sg-alb-name
  description = "For ALB"
  vpc_id      = var.vpc_id
  # アウトバウンドルール
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = var.sg-alb-name
  }
}

resource "aws_security_group_rule" "alb_http" {
  from_port         = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.sg_alb.id
  to_port           = 80
  type              = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_https" {
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.sg_alb.id
  to_port           = 443
  type              = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
}
# ECS
resource "aws_security_group" "sg_ecs" {
  name        = var.sg-ecs-name
  description = "For ECS"
  vpc_id      = var.vpc_id
  # アウトバウンドルール
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = var.sg-ecs-name
  }
}

resource "aws_security_group_rule" "ecs_http" {
  from_port         = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.sg_ecs.id
  to_port           = 80
  type              = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ecs_https" {
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.sg_ecs.id
  to_port           = 443
  type              = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
}
