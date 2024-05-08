variable "cluster_name" {
  type = string
}

variable "node_instance_type" {
  type = string
}

variable "desired_capacity" {
  type = number
}

variable "max_capacity" {
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
