aws_region   = "ap-south-1"
project_name = "stayhub"
environment  = "dev"

vpc_cidr = "10.0.0.0/16"

public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_subnet_cidrs = [
  "10.0.11.0/24",
  "10.0.12.0/24"
]

ami_id = "ami-0ac7b260cf76d8865"

eks_cluster_version = "1.31"

node_instance_type = "m7i-flex.large"

node_desired_size = 2
node_min_size     = 1
node_max_size     = 3