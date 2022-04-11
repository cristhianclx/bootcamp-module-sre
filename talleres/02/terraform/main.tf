module "alb" {
  source = "./modules/alb"
  name = var.name
  vpc_id = aws_default_vpc.main.id
  subnet_ids = local.subnet_ids_private
  certificate_arn = data.aws_acm_certificate.main.arn
  service_port = 8000
}

locals {
  subnet_ids_private = [aws_default_subnet.main_1a.id, aws_default_subnet.main_1b.id, aws_default_subnet.main_1c.id]
}

module "ecr" {
  source = "./modules/ecr"
  name   = "mf"
}

module "ecs_cluster" {
  source       = "./modules/ecs"
  cluster_name = var.cluster_name
}

module "fargate_mf" {
  source       = "./modules/fargate"
  name        = var.cluster_name
  vpc_id      = aws_default_vpc.main.id
  subnet_ids              = local.subnet_ids_private

  # Service
  service_port = 8000
  service_cpu = 2048
  service_memory = 4096
  environment_variables = {}
  ecs_cluster_arn = module.ecs_cluster.arn
  service_scale_desired = 1
  service_scale_max = 1
  service_scale_min = 1
  service_metrics_cpu_utilization_high_threshold = 80
  service_metrics_cpu_utilization_low_threshold = 20
service_metrics_memory_utilization_high_threshold = 80
service_metrics_memory_utilization_low_threshold = 20  

  # taskdefinition
  app_image      = module.ecr.repository_url
  app_port = var.app_port
  fargate_cpu    = 2048
  fargate_memory = 4096

  security_group_id = module.alb.security_group_id

  # LoadBalancer nlb
  target_group_arn = module.alb.alb_target_group_arn

  depends_on = [module.alb]
}

