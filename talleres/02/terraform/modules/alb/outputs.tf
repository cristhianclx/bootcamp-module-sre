output "alb_arn" {
  value = aws_alb.alb.arn
}
output "alb_target_group_arn" {
  value = aws_alb_target_group.service.arn
}
output "security_group_id" {
  value = aws_security_group.alb.id
}
