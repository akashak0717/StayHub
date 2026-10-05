pipeline {
    agent any

    environment {
        AWS_REGION = "ap-south-1"
        ECR_REPOSITORY = "stayhub-app"
        IMAGE_TAG = "${BUILD_NUMBER}"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                dir('app') {
                    sh 'npm ci'
                }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                echo 'SonarQube analysis will be configured'
            }
        }

        stage('Trivy Filesystem Scan') {
            steps {
                sh '''
                    trivy fs \
                    --severity HIGH,CRITICAL \
                    --exit-code 0 \
                    .
                '''
            }
        }

        stage('Docker Build') {
            steps {
                sh '''
                    docker build \
                    -t stayhub:${IMAGE_TAG} \
                    .
                '''
            }
        }

        stage('Trivy Image Scan') {
            steps {
                sh '''
                    trivy image \
                    --severity HIGH,CRITICAL \
                    --exit-code 0 \
                    stayhub:${IMAGE_TAG}
                '''
            }
        }

        stage('Login to Amazon ECR') {
            steps {
                sh '''
                    AWS_ACCOUNT_ID=$(aws sts get-caller-identity \
                    --query Account \
                    --output text)

                    ECR_REGISTRY=${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

                    aws ecr get-login-password \
                    --region ${AWS_REGION} | \
                    docker login \
                    --username AWS \
                    --password-stdin ${ECR_REGISTRY}
                '''
            }
        }

        stage('Tag Docker Image') {
            steps {
                sh '''
                    AWS_ACCOUNT_ID=$(aws sts get-caller-identity \
                    --query Account \
                    --output text)

                    ECR_REGISTRY=${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

                    docker tag stayhub:${IMAGE_TAG} \
                    ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}

                    docker tag stayhub:${IMAGE_TAG} \
                    ${ECR_REGISTRY}/${ECR_REPOSITORY}:latest
                '''
            }
        }

        stage('Push Image to ECR') {
            steps {
                sh '''
                    AWS_ACCOUNT_ID=$(aws sts get-caller-identity \
                    --query Account \
                    --output text)

                    ECR_REGISTRY=${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

                    docker push \
                    ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}

                    docker push \
                    ${ECR_REGISTRY}/${ECR_REPOSITORY}:latest
                '''
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deployment through ArgoCD will be configured later'
            }
        }
    }

    post {

        success {
            echo 'Pipeline completed successfully!'
        }

        failure {
            echo 'Pipeline failed!'
        }
    }
}