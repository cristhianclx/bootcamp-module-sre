data "aws_acm_certificate" "main" {
  domain   = var.zone
  statuses = ["ISSUED"]
}
