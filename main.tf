data "aws_vpc" "selected" {
  id = var.aws_vpc_id
}

data "aws_region" "current" {
  name = var.aws_region
}

data "aws_caller_identity" "current" {}

# The EKS cluster (if any) that represents the installation target.
data "aws_eks_cluster" "selected" {
  name  = var.cluster_name
}

data "aws_iam_policy_document" "eks_oidc_assume_role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"
    condition {
      test     = "StringEquals"
      variable = "${replace(data.aws_eks_cluster.selected.identity[0].oidc[0].issuer, "https://", "")}:sub"
      values = [
        "system:serviceaccount:${var.service_account_namespace}:${var.service_account_name}"
      ]
    }
    principals {
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${replace(data.aws_eks_cluster.selected.identity[0].oidc[0].issuer, "https://", "")}"
      ]
      type = "Federated"
    }
  }
}

resource "aws_iam_role" "this" {
  name        = "${var.cluster_name}-${var.service_account_name}-role"
  description = "Permissions required by the Kubernetes ${var.service_account_name} service account to do it's job."
  tags = var.aws_tags
  force_detach_policies = true

  assume_role_policy = data.aws_iam_policy_document.eks_oidc_assume_role.json
}

resource "aws_iam_policy" "this" {
  name = var.policy_name
  policy = var.iam_policy
}

resource "aws_iam_role_policy_attachment" "this" {
  policy_arn = aws_iam_policy.this.arn
  role       = aws_iam_role.this.name
}


resource "kubernetes_service_account" "this" {
  count = var.create_k8s_sa ? 1 :0
  metadata {
    name = var.service_account_name
    namespace = var.service_account_namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.this.arn
    }
  }
}