output "service_account" {
  value = var.create_k8s_sa ? kubernetes_service_account.this.0.metadata.0.name : null
  description = "Created service account name"
}

output "iam_policy_arn" {
  value = var.enabled ? aws_iam_policy.this.0.arn : null
  description = "IAM Policy ARN for created policy"
}

output "iam_role_arn" {
  value = var.enabled ? aws_iam_role.this.0.arn : null
  description = "IAM Role ARN for created role"
}