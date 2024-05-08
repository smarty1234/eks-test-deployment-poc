module "eks_cluster" {
  source  = "terraform-aws-modules/eks"
  version = "~> 3.0"

  name           = var.cluster_name
  role_arn        = aws_iam_role.eks_cluster.arn
  vpc_id          = aws_vpc.main.id
  subnets         = aws_subnet.private.*.id
  node_instance_type = var.node_instance_type
  desired_capacity  = var.desired_capacity
  max_capacity      = var.max_capacity

  # IAM Roles (replace with your role ARNs)
  cluster_role_arn = var.iam_role_eks_cluster
  service_role_arn = aws_iam_role.node_instance.arn
}

# VPC and Subnet Configuration (Replace with your VPC setup)
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
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
