resource "aws_ecr_repository" "nodejs_crud_api" {
  name                 = var.ecr_repo_name
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Task = "nodejs-crud"
  }
}

resource "aws_iam_policy" "ecr_pull_policy" {
  name        = "eksNodeEcrPullAccess"
  description = "Allow EKS worker nodes to pull from ECR"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_ecr_pull" {
  role       = module.eks.cluster_iam_role_name
  policy_arn = aws_iam_policy.ecr_pull_policy.arn
}
