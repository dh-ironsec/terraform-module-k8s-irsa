resource "aws_iam_role" "this" {

  name = var.role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::${var.account_id}:oidc-provider/${var.oidc_url}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "${var.oidc_url}:sub": "system:serviceaccount:${var.service_account_namespace}:${var.service_account_name}"
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_policy" "this" {
  name = var.policy_name
  policy = var.iam_policy
}

resource "kubernetes_service_account" "this" {
  metadata {
    name = var.service_account_name
    namespace = var.service_account_namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.this.arn
    }
  }
}