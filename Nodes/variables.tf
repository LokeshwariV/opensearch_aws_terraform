variable "aws_region" { 
  description = "AWS region where EC2 will be hosted"
  type = string 
  default = "eu-north-1"
}

variable "aws_ami" { 
  type = string 
  default = "ami-02d0a1cbe2c3e5ae4"
}

variable "instance_type" { 
  type = string 
  default = "t2.micro"
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

variable "secgroupname" {
  type = string
  default = "sg"
}

variable "vpc" {
  type = string
  default = "vpc-0ecd126b89b46b4a2"
}

variable "subnet_id" {
  type = string
  default = "subnet-004ac0c4aff3146b3"
}

variable "publicip" {
  default = true
}

variable "keyname" {
  default = "myseckey"
}