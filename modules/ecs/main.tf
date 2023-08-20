resource "aws_cloudwatch_log_group" "main" {
  name = "${var.ecs-base-name}-log-group"
}

resource "aws_ecs_cluster" "main" {
  name = var.ecs-base-name

  tags = {
    Name = "${var.ecs-base-name}"
  }

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "main" {
  family                   = "${var.ecs-base-name}-def"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = var.ecs_deploy_iam_role_arn
  task_role_arn            = var.ecs_deploy_iam_role_arn

  container_definitions = jsonencode([
    {
      name   = "app"
      image  = "${var.aws_ecr_repository_main_repository_url}:latest"
      cpu    = 128
      memory = 256

      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-region : "ap-northeast-1"
          awslogs-group : aws_cloudwatch_log_group.main.name
          awslogs-stream-prefix : "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "main" {
  name                = "${var.ecs-base-name}-service"
  cluster             = aws_ecs_cluster.main.id
  task_definition     = aws_ecs_task_definition.main.arn
  desired_count       = 3
  launch_type         = "FARGATE"
  scheduling_strategy = "REPLICA"

  propagate_tags = "SERVICE"

  network_configuration {
    security_groups = [var.sg_ecs_id]
    subnets = [
      var.aws_subnet_private_1a,
      var.aws_subnet_private_1c,
      var.aws_subnet_private_1d
    ]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.alb_tg_main_arn
    container_name   = "app"
    container_port   = 80
  }

  deployment_controller {
    type = "ECS" # Default Setting
    #type = "CODE_DEPLOY"
  }
}
resource "aws_lb_listener_rule" "main" {
  listener_arn = var.aws_lb_listener_https_arn
  priority     = 50000
  action {
    type             = "forward"
    target_group_arn = var.alb_tg_main_arn
  }
  condition {
    path_pattern { values = ["/*"] }
  }
}
