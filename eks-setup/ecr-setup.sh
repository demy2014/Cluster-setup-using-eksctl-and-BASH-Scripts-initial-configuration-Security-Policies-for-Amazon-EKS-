#!/bin/bash

# Variables
REPOSITORIES=("ca-agency-service-dev" "ca-auth-service-dev" "ca-casting-service-dev" "ca-talent-service-dev" "ca-upload-service-dev")
REGION="us-west-1"
ACCOUNT_ID="981666308374"

# Create ECR repositories
for REPO in "${REPOSITORIES[@]}"; do
  aws ecr create-repository --repository-name $REPO --region $REGION
done

# Authenticate Docker to ECR
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com

# Build Docker images and push them
for REPO in "${REPOSITORIES[@]}"; do
  docker build -t $REPO .
  docker tag $REPO:latest ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/$REPO:latest
  docker push ${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/$REPO:latest
done

