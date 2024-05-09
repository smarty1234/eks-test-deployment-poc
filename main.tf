
provider "aws" {
  region = "us-east-2"
  
}

# VPC and Subnet Configuration (Replace with your VPC setup)
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}


# IAM Roles (Replace with your actual IAM role definitions)
resource "aws_iam_role" "eks_cluster" {
  name = var.iam_role_eks_cluster

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.29"

  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id                   = var.vpc_id
  subnet_ids               = var.public_subnets
  control_plane_subnet_ids = var.private_subnets

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["m6i.large", "m5.large", "m5n.large", "m5zn.large"]
  }

  eks_managed_node_groups = {
    poc = {
      min_size     = var.asg_desired_capacity
      max_size     = var.asg_max_capacity
      desired_size = var.asg_desired_capacity

      instance_types = ["t3.large"]
      capacity_type  = "SPOT"
    }
  }

  # Cluster access entry
  # To add the current caller identity as an administrator
  enable_cluster_creator_admin_permissions = true

  access_entries = {
    # One access entry with a policy associated
    poc = {
      kubernetes_groups = []
      principal_arn     = var.iam_role_eks_cluster_arn

      policy_associations = {
        poc= {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSViewPolicy"
          access_scope = {
            namespaces = ["default"]
            type       = "namespace"
          }
        }
      }
    }
  }

  tags = {
    Environment = "poc"
    Terraform   = "true"
  }
}



resource "aws_subnet" "private" {
  count = 2
  vpc_id          = aws_vpc.main.id
  cidr_block      = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index + 1)
  availability_zone = "us-east-2a"

  tags = {
    Name = format("private-subnet-%d", count.index + 1)
  }
}

resource "aws_iam_role" "node_instance" {
  name = var.iam_role_node_instance

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
