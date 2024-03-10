resource "aws_iam_role_policy" "opensearch_access_role_policy" {
  name = "opensearch_access_role_policy"
  role = aws_iam_role.opensearch_access_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        "Resource": "arn:aws:es:${var.aws_region}:901407365530:domain/${var.domain}/*"
      },
    ]
  })
}

resource "aws_iam_role" "opensearch_access_role" {
  name = "opensearch_access_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

