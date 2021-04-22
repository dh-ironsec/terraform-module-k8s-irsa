output "service_account" {
  value = kubernetes_service_account.this.metadata.name
  description = "Created service account name"
}

output "iam_policy_arn" {
  value = aws_iam_policy.this.arn
  description = "IAM Policy ARN for created policy"
}

output "iam_role_arn" {
  value = aws_iam_role.this.arn
  description = "IAM Role ARN for created role"
}