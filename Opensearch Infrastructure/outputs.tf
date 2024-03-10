output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "opensearch_master_password" {
  value = random_password.master_password.result
  sensitive = true
}