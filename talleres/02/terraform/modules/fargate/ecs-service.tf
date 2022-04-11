resource "aws_ecs_task_definition" "service" {
  family = "${var.name}-service"

  execution_role_arn = aws_iam_role.ecs_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_role.arn

  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = var.service_cpu
  memory = var.service_memory

  container_definitions = templatefile("${path.module}/ecs-service.json", {
    name           = var.name,
    app_image      = var.app_image,
    fargate_cpu    = var.fargate_cpu,
    fargate_memory = var.fargate_memory,
    app_port       = var.app_port
  })
}

resource "aws_ecs_service" "service" {
  name = "${var.name}-service"

  cluster         = var.ecs_cluster_arn
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.service.arn
  desired_count   = var.service_scale_desired

  network_configuration {
    security_groups  = [aws_security_group.tasks.id]
    subnets          = var.subnet_ids
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "${var.name}-service"
    container_port   = var.service_port
  }
}

resource "aws_appautoscaling_target" "service_scale" {
  service_namespace = "ecs"
  resource_id       = "service/${var.name}/${aws_ecs_service.service.name}"

  scalable_dimension = "ecs:service:DesiredCount"
  max_capacity       = var.service_scale_max
  min_capacity       = var.service_scale_min
}
