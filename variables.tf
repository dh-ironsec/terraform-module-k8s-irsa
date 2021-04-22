variable "role_name" {
  description = "AWS IAM Role Name"
  type = string
}

variable "policy_name" {
  description = "AWS IAM Policy Name"
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

variable "aws_tags" {
  default = {}
  type = map(string)
  description = "AWS Tags Map"
}

variable "aws_region" {
  default = "us-east-1"
  type = string
  description = "AWS Region"
}

variable "aws_vpc_id" {
  description = "AWS VPC ID"
  type = string
}

variable "cluster_name" {
  description = "EKS Cluster name"
}

variable "create_k8s_sa" {
  default = false
  type = bool
  description = "Create k8s service account"
}