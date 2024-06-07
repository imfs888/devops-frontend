#!/bin/bash 

# Set environment variables
export CONTAINER_NAME="devops-frontend"
export AWS_DEFAULT_REGION="us-east-1"
export AWS_ACCOUNT_ID="590183909822"
export REPOSITORY_URI="590183909822.dkr.ecr.us-east-1.amazonaws.com/frontend"
export IMAGE_TAG="latest"
VITE_BACKEND_URL=$(aws elbv2 describe-load-balancers --query "LoadBalancers[?contains(DNSName, 'devops-terraform-project-be-lb')].[DNSName]" --output text)
export VITE_BACKEND_URL

# ECR login
aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com

# Pulling image from ECR
docker pull ${REPOSITORY_URI}:${IMAGE_TAG}

# Creating and starting a docker container using a new image
docker run -d -p 4000:4000 -e VITE_BACKEND_URL="${VITE_BACKEND_URL}" --name ${CONTAINER_NAME} ${REPOSITORY_URI}:${IMAGE_TAG}
