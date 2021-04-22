variable "role_name" {
  description = "AWS IAM Role Name"
  type = string
}

variable "policy_name" {
  description = "AWS IAM Policy Name"
  type = string
}

variable "account_id" {
  description = "AWSAccount ID"
  type = string
}

variable "oidc_url" {
  description = "OIDC URL for cluster"
  type = string
}

variable "service_account_name" {
  description = "K8s Service account name"
  type = string
}

variable "service_account_namespace" {
  description = "Service account namespace"
  type = string
}

variable "iam_policy" {
  description = "IAM policy for k8s service account"
  type = string
}