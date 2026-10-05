StayHub is a full-stack accommodation/listing web application with an end-to-end DevOps, CI/CD, Kubernetes, GitOps, progressive delivery, and monitoring workflow.

## 📌 Project Overview

StayHub allows users to:

- Register and login
- Create accommodation listings
- View, edit, and delete listings
- Upload listing images
- Add reviews and ratings
- Search and filter listings
- View listing locations

The project is designed to demonstrate a complete cloud-native DevOps workflow.

## 🛠️ Technology Stack

### Application
- Node.js
- Express.js
- MongoDB
- Mongoose
- EJS
- Passport.js
- Cloudinary
- Joi
- JavaScript

### DevOps
- Git
- GitHub
- Jenkins
- Docker
- Amazon ECR
- SonarQube
- Trivy

### Infrastructure
- Terraform
- Ansible
- AWS EC2
- AWS VPC
- AWS IAM
- AWS ECR
- Amazon EKS
- Internet Gateway
- NAT Gateway
- Security Groups
- Route Tables
- Subnets

### Kubernetes
- Kubernetes
- Helm
- Argo CD
- Argo Rollouts

### Monitoring
- Prometheus
- Grafana

## 🏗️ Architecture

```text
Developer
    |
    | git push
    v
GitHub
    |
    | Webhook
    v
Jenkins
    |
    +--> SonarQube
    |
    +--> Trivy
    |
    v
Docker Build
    |
    v
Amazon ECR
    |
    v
Argo CD
    |
    v
Helm
    |
    v
Amazon EKS
    |
    +--> StayHub
    |
    +--> Argo Rollouts
    |       |
    |       +--> Blue-Green Deployment
    |
    +--> Prometheus
            |
            v
          Grafana
```

## ☁️ AWS Architecture

AWS Region:

```text
ap-south-1
```

VPC CIDR:

```text
10.0.0.0/16
```

### Public Subnets

```text
10.0.1.0/24
10.0.2.0/24
```

### Private Subnets

```text
10.0.11.0/24
10.0.12.0/24
```

The VPC contains:

- Internet Gateway
- NAT Gateway
- Elastic IP
- Public Route Table
- Private Route Table
- Public Subnets
- Private Subnets

## 🏗️ Terraform

Terraform is used as Infrastructure as Code to provision:

- VPC
- Subnets
- Internet Gateway
- NAT Gateway
- Route Tables
- Security Groups
- IAM Roles
- Jenkins EC2
- ECR Repository
- EKS Cluster
- EKS Node Group

### Terraform Structure

```text
terraform/
├── modules/
│   ├── vpc/
│   ├── security-group/
│   ├── iam/
│   ├── ec2/
│   ├── ecr/
│   └── eks/
├── main.tf
├── provider.tf
├── variables.tf
├── outputs.tf
└── terraform.tfvars
```

### Terraform Commands

```bash
terraform init
terraform validate
terraform plan
terraform apply
terraform destroy
```

## 🐳 Docker

StayHub is containerized using Docker with a multi-stage Docker build.

### Build

Run from the project root:

```bash
docker build -t stayhub:v1 .
```

### Run

```bash
docker run --name stayhub-container \
  --env-file ./app/.env \
  -p 8081:8081 \
  stayhub:v1
```

Application:

```text
http://localhost:8081
```

## 📦 Amazon ECR

Amazon ECR is used as the private container registry.

Repository:

```text
stayhub-app
```

Example image:

```text
<ACCOUNT_ID>.dkr.ecr.ap-south-1.amazonaws.com/stayhub-app:latest
```

## 🔄 Jenkins CI/CD

Jenkins automates the CI/CD workflow:

```text
GitHub Checkout
      |
      v
Install Dependencies
      |
      v
SonarQube Analysis
      |
      v
Trivy Filesystem Scan
      |
      v
Docker Build
      |
      v
Trivy Image Scan
      |
      v
AWS ECR Login
      |
      v
Docker Image Tag
      |
      v
Push Image to ECR
      |
      v
GitOps Deployment
```

The pipeline is defined in:

```text
Jenkinsfile
```

## 🔐 Trivy

Trivy is used for filesystem and container image security scanning.

### Filesystem Scan

```bash
trivy fs .
```

### Docker Image Scan

```bash
trivy image stayhub:v1
```

## 📊 SonarQube

SonarQube is used for static code analysis and helps identify:

- Bugs
- Code smells
- Vulnerabilities
- Maintainability issues
- Code quality problems

## ⚙️ Ansible

Ansible is used to configure the Jenkins server automatically.

The Jenkins server is configured with:

- Java 21
- Docker
- Jenkins
- AWS CLI
- kubectl
- Helm
- Trivy
- Git

### Ansible Structure

```text
ansible/
├── inventory/
│   └── hosts.ini
├── playbooks/
│   └── jenkins-server.yaml
├── roles/
│   ├── aws-cli/
│   ├── common/
│   ├── docker/
│   ├── helm/
│   ├── java/
│   ├── jenkins/
│   ├── kubectl/
│   └── trivy/
└── ansible.cfg
```

## ☸️ Kubernetes / Amazon EKS

Amazon EKS is used as the managed Kubernetes platform.

Cluster:

```text
stayhub-eks
```

Node Group:

```text
stayhub-nodes
```

The cluster is designed to run:

- StayHub
- Argo CD
- Argo Rollouts
- Prometheus
- Grafana

## ⚓ Helm

Helm is used to package and deploy StayHub to Kubernetes.

### Helm Structure

```text
helm/
└── stayhub/
    ├── templates/
    │   ├── _helpers.tpl
    │   ├── configmap.yaml
    │   ├── preview-service.yaml
    │   ├── rollout.yaml
    │   ├── secret.yaml
    │   └── service.yaml
    ├── Chart.yaml
    ├── values.yaml
    └── rendered-output.yaml
```

## 🔁 GitOps with Argo CD

Argo CD implements the GitOps deployment model.

GitHub acts as the source of truth for Kubernetes configuration.

```text
GitHub
   |
   v
Argo CD
   |
   v
Helm
   |
   v
Amazon EKS
```

Argo CD continuously monitors the Git repository and synchronizes the desired state with the Kubernetes cluster.

Configuration:

```text
argocd/
```

## 🔵🟢 Argo Rollouts

Argo Rollouts provides progressive application delivery.

StayHub uses a Blue-Green deployment strategy.

```text
                    Argo Rollout
                         |
              +----------+----------+
              |                     |
              v                     v
        Active Service       Preview Service
              |                     |
              v                     v
        Current Version        New Version
```

Services:

```text
stayhub-active
stayhub-preview
```

Configuration:

```text
argocd-rollouts/
```

The Rollout manifest is also included in the StayHub Helm chart.

## 📈 Monitoring

Prometheus and Grafana are used for Kubernetes monitoring.

### Prometheus

Prometheus collects and stores metrics.

### Grafana

Grafana visualizes Prometheus metrics using dashboards.

```text
Kubernetes
    |
    v
Prometheus
    |
    v
Grafana
```

Monitoring configuration:

```text
monitoring/
```

## 🔒 Environment Variables and Secrets

Sensitive information must never be committed to GitHub.

Examples:

```text
MONGO_URL
SESSION_SECRET
CLOUD_NAME
CLOUD_API_KEY
CLOUD_API_SECRET
```

Local environment configuration:

```text
app/.env
```

The `.env` file is excluded through `.gitignore`.

Never commit:

- MongoDB passwords
- API keys
- Cloudinary secrets
- AWS credentials
- Access keys
- Secret tokens
- Private keys

## 📁 Project Structure

```text
StayHub/
├── app/
│   ├── controllers/
│   ├── init/
│   ├── models/
│   ├── public/
│   ├── routes/
│   ├── utils/
│   ├── views/
│   ├── app.js
│   ├── cloudConfig.js
│   ├── middleware.js
│   ├── package.json
│   └── schema.js
│
├── ansible/
│   ├── inventory/
│   ├── playbooks/
│   ├── roles/
│   └── ansible.cfg
│
├── argocd/
├── argocd-rollouts/
│
├── helm/
│   └── stayhub/
│       ├── templates/
│       ├── Chart.yaml
│       ├── values.yaml
│       └── rendered-output.yaml
│
├── monitoring/
│
├── terraform/
│   ├── modules/
│   │   ├── vpc/
│   │   ├── security-group/
│   │   ├── iam/
│   │   ├── ec2/
│   │   ├── ecr/
│   │   └── eks/
│   ├── main.tf
│   ├── provider.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars
│
├── .dockerignore
├── .gitignore
├── Dockerfile
├── Jenkinsfile
├── LICENSE
└── README.md
```

## 🔁 Complete CI/CD + GitOps Workflow

```text
                         Git Push
                            |
                            v
                         GitHub
                            |
                            v
                         Jenkins
                            |
             +--------------+--------------+
             |                             |
             v                             v
         SonarQube                       Trivy
             |                             |
             +--------------+--------------+
                            |
                            v
                         Docker
                            |
                            v
                           ECR
                            |
                            v
                         Argo CD
                            |
                            v
                           Helm
                            |
                            v
                           EKS
                            |
             +--------------+--------------+
             |              |              |
             v              v              v
          StayHub      Argo Rollouts   Monitoring
                            |              |
                            v              v
                       Blue-Green      Prometheus
                       Deployment          |
                                           v
                                        Grafana
```

## 🎯 Project Goals

This project demonstrates practical experience with:

- Linux
- Git and GitHub
- Docker
- Jenkins
- CI/CD
- SonarQube
- Trivy
- AWS
- IAM
- VPC
- EC2
- ECR
- EKS
- Terraform
- Ansible
- Kubernetes
- Helm
- GitOps
- Argo CD
- Argo Rollouts
- Blue-Green Deployment
- Prometheus
- Grafana
- Infrastructure as Code
- Container Security
- Progressive Delivery

## 👨‍💻 Author

**Akash Aralikatti**

DevOps / Cloud Engineer

GitHub:

https://github.com/akashak0717

Project:

https://github.com/akashak0717/StayHub

## ⭐ Project Status

```text
Application Development       ✅
MongoDB Integration           ✅
Dockerization                 ✅
Local Docker Testing          ✅
Terraform Configuration       ✅
Ansible Configuration         ✅
Helm Configuration            ✅
GitHub Repository             🚧
Jenkins CI/CD                 🚧
AWS ECR                       🚧
Amazon EKS                    🚧
Argo CD                       🚧
Argo Rollouts                 🚧
Prometheus                    🚧
Grafana                       🚧
Complete GitOps Pipeline      🚧
```
'''
path = Path("/mnt/data/README.md")
path.write_text(readme, encoding="utf-8")
print(f"Created: {path}")