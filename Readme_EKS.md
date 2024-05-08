- IAM Roles and Policies
  - EKS Cluster Role:
1. Create IAM Role with `AmazonEKSClusterPolicy` attached.
  - Node Instance Role
2. Create an IAM role with `AmazonEC2ContainerServiceforLinuxRole` and `AmazonS3FullAccess` policies attached.
