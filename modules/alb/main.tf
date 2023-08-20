resource "aws_lb" "main" {
  name               = var.alb-name
  load_balancer_type = "application"
  security_groups = [
    var.sg_alb_id
  ]
  subnets = [
    var.aws_subnet_public_1a,
    var.aws_subnet_public_1c,
    var.aws_subnet_public_1d
  ]
}

resource "aws_lb_target_group" "main" {
  name        = var.alb-tg-name
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
  deregistration_delay = 60
  #health_check { path = "/index.html" }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.main.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = var.cert_arn
  default_action {
    #type             = "forward"
    #target_group_arn = aws_lb_target_group.main.arn
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "503 Service Temporarily Unavailable [XXX]"
      status_code  = "503"
    }
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
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

####################################################
# Route53 record for ALB
####################################################
resource "aws_route53_record" "a_record_for_app_subdomain" {
  name    = var.dns-domain-name
  type    = "A"
  zone_id = var.zone-id
  alias {
    evaluate_target_health = true
    name                   = aws_lb.main.dns_name
    zone_id                = aws_lb.main.zone_id
  }
}
