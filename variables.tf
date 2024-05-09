

variable "region" {
  type = string
}

variable "vpc_id" {
  type = string
}
variable "cluster_name" {
  type = string
}

variable "node_instance_type" {
  type = string
}

variable "asg_desired_capacity" {
  type = number
}

variable "asg_max_capacity" {
  type = number
}

variable "s3_bucket_name" {
  type = string
}

variable "iam_role_eks_cluster" {
  type = string
}

variable "iam_role_node_instance" {
  type = string
}
variable "public_subnets" {
  type = list
}
variable "private_subnets" {
  type = list
}