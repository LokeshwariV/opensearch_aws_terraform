provider "aws" {
  region = var.aws_region
}

locals {
    domain = "${var.domain}"
}


resource "random_password" "master_password" {
  length  = 10
  special = true
  upper = true
  lower = true
  numeric = true
}

resource "aws_opensearch_domain" "opensearch" {
  domain_name           = local.domain
  engine_version        = "OpenSearch_${var.opensearch_version}"
  
  cluster_config {
    instance_type = var.instance_type
    instance_count = var.instance_count
    zone_awareness_enabled = false
  }

  ebs_options {
    ebs_enabled = true
    volume_type = var.ebs_volume_type
    volume_size = var.ebs_volume_size
  }

  access_policies = jsonencode({
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "AWS": "*"
          },
          "Action": "es:*",
          "Resource": "arn:aws:es:${var.aws_region}:${data.aws_caller_identity.current.account_id}:domain/${local.domain}/*"
        }
      ] 
    })

    advanced_security_options {
    enabled                        = true
    anonymous_auth_enabled         = false
    internal_user_database_enabled = true
    master_user_options {
      master_user_name     = var.opensearch_master_user
      master_user_password = coalesce(var.opensearch_master_password, random_password.master_password.result)
    }
  }

  encrypt_at_rest {
    enabled = true
  }

  node_to_node_encryption {
    enabled = true
  }

  domain_endpoint_options {
    enforce_https = true
    tls_security_policy   = "Policy-Min-TLS-1-2-2019-07"
  }

  #   vpc_options {
  #   subnet_ids = var.subnet_ids

  #   security_group_ids = [aws_security_group.opensearch_security_group.id]
  # }

}

# resource "aws_security_group" "opensearch_security_group" {
#   name        = "${local.domain}-sg"
#   vpc_id      = data.aws_vpc.selected.id
#   description = "Allow inbound HTTP traffic"

#   ingress {
#     description = "HTTP from VPC"
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"

#     cidr_blocks = [
#       data.aws_vpc.selected.cidr_block,
#     ]
#   }
# }

#   vpc_options {
#     subnet_ids = ["subnet-004ac0c4aff3146b3"]
#     security_group_ids = ["sg-0b9e8097ecd684129"]
#   }

# To attach an access policy to the OpenSearch domain
# data "aws_iam_policy_document" "main" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "*"
#       identifiers = ["*"]
#     }

#     actions   = ["es:*"]
#     resources = ["${aws_opensearch_domain.opensearch.arn}/*"]

#     condition {
#       test     = "IpAddress"
#       variable = "aws:SourceIp"
#       values   = ["127.0.0.1/32"]
#     }
#   }
# }

# resource "aws_opensearch_domain_policy" "main" {
#   domain_name     = aws_opensearch_domain.opensearch.${var.domain}
#   access_policies = data.aws_iam_policy_document.main.json
# }