- IAM Roles and Policies
  -- EKS Cluster Role:
1. Create IAM Role with `AmazonEKSClusterPolicy` attached.
   Define a variable: `iam_role_eks_cluster`
  -- Node Instance Role
2. Create an IAM role with `AmazonEC2ContainerServiceforLinuxRole` and `AmazonS3FullAccess` policies attached.
    Define a variable: `iam_role_node_instance`

Create 3 files: `main.tf`, `variable.tf` and `backend.tf`
This will use terraform modules: `terraform-aws-modules/eks`
