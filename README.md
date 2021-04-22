# terraform-module-k8s-irsa

Create Kubernetes service account with an attached IAM Role

## TODO

- [ ] Add Cluster Role binding option

## Example

```terraform
module "irsa_sa" {
  source = "git@github.com:dh-ironsec/terraform-module-k8s-irsa.git"
  version = "1.0.0"
  role_name = "aws-load-balancer-controller"
  policy_name = "AWSLoadBalancerControllerIAMPolicy"
  iam_policy = file("path/to/policy.json")
  account_id = "123454567"
  oidc_url = "https://oidc.eks.us-west-2.amazonaws.com/id/EXAMPLED539D4633E53DE1B716D3041E"
  service_account_name = "aws-alb-controller"
  service_account_namespace = "kube-system"
}
```

## Requirements

No requirements.

## Providers

The following providers are used by this module:

- aws

- kubernetes

## Modules

No Modules.

## Resources

The following resources are used by this module:

- [aws_iam_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy)
- [aws_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)
- [kubernetes_service_account](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account)

## Required Inputs

The following input variables are required:

### account\_id

Description: AWSAccount ID

Type: `string`

### iam\_policy

Description: IAM policy for k8s service account

Type: `string`

### oidc\_url

Description: OIDC URL for cluster

Type: `string`

### policy\_name

Description: AWS IAM Policy Name

Type: `string`

### role\_name

Description: AWS IAM Role Name

Type: `string`

### service\_account\_name

Description: K8s Service account name

Type: `string`

### service\_account\_namespace

Description: Service account namespace

Type: `string`

## Optional Inputs

No optional input.

## Outputs

The following outputs are exported:

### iam\_policy\_arn

Description: IAM Policy ARN for created policy

### iam\_role\_arn

Description: IAM Role ARN for created role

### service\_account

Description: Created service account name
