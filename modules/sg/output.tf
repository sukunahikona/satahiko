output "sg_board_id" {
  value = aws_security_group.sg_board.id
}
output "sg_alb_id" {
  value = aws_security_group.sg_alb.id
}
output "sg_ecs_id" {
  value = aws_security_group.sg_ecs.id
}

