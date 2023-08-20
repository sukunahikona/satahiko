resource "aws_iam_role" "ecs_deploy" {
  name = "ecs_deploy_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = { Service = "ecs-tasks.amazonaws.com" }
      },
    ]
  })
  
  inline_policy {
    name = "allow_logs"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          Action = [
            "logs:CreateLogStream",
            "logs:DescribeLogGroups",
            "logs:DescribeLogStreams",
            "logs:PutLogEvents",
          ],
          Resource = "*"
        }
      ]
    })
  }
  #managed_policy_arns = [
  #  "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  #]
}

resource "aws_iam_policy" "ecs_deploy_policy" {
  name = "ecs_deploy_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ecr:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_policy_attachment" "attach" {
  name       = "iam-attach"
  roles      = ["${aws_iam_role.ecs_deploy.name}"]
  policy_arn = aws_iam_policy.ecs_deploy_policy.arn
}
