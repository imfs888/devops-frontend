#!/bin/bash 
export CONTAINER_NAME="devops-frontend"

# ECR Login
aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com

# Pulling image from ECR
docker pull ${REPOSITORY_URI}:${IMAGE_TAG}

# Creating and starting a docker container using a new image
docker run -d -p 4000:4000 --name $CONTAINER_NAME docker push ${REPOSITORY_URI}:${IMAGE_TAG}
