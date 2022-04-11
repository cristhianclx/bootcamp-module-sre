resource "aws_alb" "alb" {
  name               = "${var.name}-alb"
  subnets            = var.subnet_ids
  security_groups    = [aws_security_group.alb.id]
  load_balancer_type = "application"
  idle_timeout       = 300
  enable_http2       = true
}

resource "aws_alb_listener" "alb_http" {
  load_balancer_arn = aws_alb.alb.id
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
resource "aws_alb_listener" "alb_https" {
  load_balancer_arn = aws_alb.alb.id
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.service.id
  }
}

resource "aws_alb_target_group" "service" {
  name                 = "${var.name}-service"
  port                 = var.service_port
  protocol             = "HTTP"
  vpc_id               = var.vpc_id
  target_type          = "ip"
  deregistration_delay = 300
}
