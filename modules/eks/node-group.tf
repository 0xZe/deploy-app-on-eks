resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "node_group"
  node_role_arn   = aws_iam_role.NodeGroupRole.arn
  subnet_ids      = var.private_subnets_id

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  remote_access {
    ec2_ssh_key = "key"
  }

  ami_type       = "AL2_x86_64"
  instance_types = ["t2.medium"]
  capacity_type  = "ON_DEMAND"
  disk_size      = 20

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy
  ]
}
