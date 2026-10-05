module "vpc" {
  source = "./modules/vpc"

  project_name         = var.project_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "security_group" {
  source = "./modules/security-group"

  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
}

module "iam" {
  source = "./modules/iam"

  project_name = var.project_name
}

module "ec2" {
  source = "./modules/ec2"

  instance_name        = "${var.project_name}-jenkins"
  ami_id               = var.ami_id
  instance_type        = var.instance_type
  subnet_id            = module.vpc.public_subnet_ids[0]
  security_group_id    = module.security_group.jenkins_security_group_id
  iam_instance_profile = module.iam.jenkins_instance_profile_name
}

module "eks" {
  source = "./modules/eks"

  project_name       = var.project_name
  cluster_version    = var.eks_cluster_version
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids

  cluster_role_arn = module.iam.eks_cluster_role_arn
  node_role_arn    = module.iam.eks_node_role_arn

  node_instance_type = var.node_instance_type
  desired_size       = var.node_desired_size
  min_size           = var.node_min_size
  max_size           = var.node_max_size
}

module "ecr" {
  source = "./modules/ecr"

  project_name = var.project_name
}