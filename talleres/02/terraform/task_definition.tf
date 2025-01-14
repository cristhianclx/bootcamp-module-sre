resource "aws_ecs_task_definition" "main" {
  family                   = var.name
  task_role_arn            = aws_iam_role.task_role.arn
  execution_role_arn       = aws_iam_role.main_ecs_tasks.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory

  container_definitions = jsonencode([
    {
      name        = var.name
      image       = var.app_image
      cpu         = var.fargate_cpu
      memory      = var.fargate_memory
      networkMode = "awsvpc"
      ulimits = [
        {
          "name" : "nofile",
          "softLimit" : 65536,
          "hardLimit" : 65536
        }
      ]
      portMappings = [
        {
          containerPort = var.app_port
          protocol      = "tcp"
          hostPort      = var.app_port
        }
      ]
      environment = var.environment_variables
      logConfiguration : {
        logDriver : "awslogs"
        options : {
          awslogs-group         = "awslogs/${var.name}/fargate"
          awslogs-region        = "us-east-1"
          awslogs-stream-prefix = "streaming"
          awslogs-create-group  = "true"
        }
      }
    }
  ])
}
