variable "aws_region" { 
  description = "AWS region where Opensearch will be hosted"
  type = string 
  default = "eu-north-1"
}

variable "domain" { 
  description = "Opensearch Domain Name"
  type = string 
  default = "opensearch-demo"
}

variable "opensearch_version" {
  description = "Opensearch engine version"
  type = string
  default = "2.11"
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t3.small.search"
}

variable "instance_count" {
  description = "Instance count"
  type        = number
  default     = 1
}

variable "ebs_volume_type" {
  description = "Instance type"
  type        = string
  default     = "gp3"
}

variable "ebs_volume_size" {
  description = "Instance count"
  type        = number
  default     = 10
}

variable "opensearch_master_user" {
  description = "opensearch master username to access opensearch"
  type        = string
  default     = "admin"
}

variable "opensearch_master_password" {
  description = "opensearch master password to access opensearch"
  type        = string
  default     = ""
}

# To provision opensearch in respective VPC 
# variable "vpc" {
#   description = "VPC ID"
#   type        = string
#   default     = ""
# }

# variable "subnet_ids" {
#   description = "CIDS blocks of subnets."
#   type        = list(string)
#   default     = []
# }