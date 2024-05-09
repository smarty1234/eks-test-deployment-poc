- IAM Roles and Policies
  -- EKS Cluster Role:
1. Create IAM Role with `AmazonEKSClusterPolicy` attached.
Go to `https://us-east-1.console.aws.amazon.com/iam/home?region=us-east-2#/roles/create`
Select `AWS Service`
Select Service Radio Buton: `EKS - Cluster`
Select `Next` - see that `AmazonEKSClusterPolicy` is attached as AWS Managed Policy
Select `Next`
Add a Role name: `mpadhi_test_eks_cluster_role`
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "eks.amazonaws.com"
                ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
```
Add tag: Purpose: POC
flag_for_delete: 1
Click `Create Role`

Define a variable: `iam_role_eks_cluster` value `mpadhi_test_eks_cluster_role`

  -- Node Instance Role
  Use same as sbove but select this time  Service S3 Policy:
2. Create an IAM role with `AmazonEKSServicePolicy`, `AmazonEKSFargatePodExecutionRolePolicy`
 and `AmazonS3FullAccess` policies attached.

Use same as sbove but select this time  the avove policies to save as role: `mpadhi_test_eks_service_s3_role`

Add tag: Purpose: POC
flag_for_delete: 1
Click `Create Role`

    Define a variable: `iam_role_node_instance` to value `mpadhi_test_eks_service_s3_role`
3. create a s3 bucket as shown in backend.tf - this needs hardcoded name.

Create 4 files: `main.tf`, `variable.tf` and `backend.tf`, `myvars.tfvars`
This will use terraform modules: `terraform-aws-modules/eks/aws`

```
bash-3.2$ terraform init

Initializing the backend...

Successfully configured the backend "s3"! Terraform will automatically
use this backend unless the backend configuration changes.
Initializing modules...

Initializing provider plugins...
- Finding hashicorp/aws versions matching ">= 4.33.0, >= 5.40.0"...
- Finding hashicorp/tls versions matching ">= 3.0.0"...
- Finding hashicorp/time versions matching ">= 0.9.0"...
- Finding hashicorp/cloudinit versions matching ">= 2.0.0"...
- Finding hashicorp/null versions matching ">= 3.0.0"...
- Installing hashicorp/null v3.2.2...
- Installed hashicorp/null v3.2.2 (signed by HashiCorp)
- Installing hashicorp/aws v5.48.0...
- Installed hashicorp/aws v5.48.0 (signed by HashiCorp)
- Installing hashicorp/tls v4.0.5...
- Installed hashicorp/tls v4.0.5 (signed by HashiCorp)
- Installing hashicorp/time v0.11.1...
- Installed hashicorp/time v0.11.1 (signed by HashiCorp)
- Installing hashicorp/cloudinit v2.3.4...
- Installed hashicorp/cloudinit v2.3.4 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

```
`terraform plan -var-file=myvars.tfvars`
bash-3.2$ terraform plan
var.cluster_name
  Enter a value: my-test-cluster

var.desired_capacity
  Enter a value: 1

var.iam_role_eks_cluster
  Enter a value: mpadhi_test_eks_cluster_role

var.iam_role_node_instance
  Enter a value: mpadhi_test_eks_service_s3_role

var.max_capacity
  Enter a value: 3

var.node_instance_type
  Enter a value: t2.small

var.region
  Enter a value: us-east-2

var.s3_bucket_name
  Enter a value: mpadhi-example-bucket-eks-001
```