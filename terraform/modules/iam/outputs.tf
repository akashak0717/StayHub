# Jenkins EC2 Instance Profile

output "jenkins_instance_profile_name" {
  description = "IAM instance profile name for Jenkins EC2"
  value       = aws_iam_instance_profile.jenkins_ec2_profile.name
}


# EKS Cluster Role ARN

output "eks_cluster_role_arn" {
  description = "IAM role ARN for EKS cluster"
  value       = aws_iam_role.eks_cluster_role.arn
}


# EKS Node Role ARN

output "eks_node_role_arn" {
  description = "IAM role ARN for EKS worker nodes"
  value       = aws_iam_role.eks_node_role.arn
}