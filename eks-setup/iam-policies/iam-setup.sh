#!/bin/bash

# Variables
CLUSTER_NAME="casting-dev-cluster"
REGION="us-west-1"
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
TRUST_POLICY_FILE="iam-policies/trust-policy.json"  # Adjust path as needed

# Function to create IAM role with trust policy
create_iam_role() {
    local ROLE_NAME=$1
    aws iam create-role --role-name 
eksctl-casting-k8s-cluster-dev-cluster-ServiceRole-lryfbfpFDdpb  --assume-role-policy-document file://$TRUST_POLICY_FILE
    aws iam attach-role-policy --role-name 
eksctl-casting-k8s-cluster-dev-cluster-ServiceRole-lryfbfpFDdpb  --policy-arn arn:aws:iam::aws:policy/AmazonEKSClusterPolicy
    aws iam attach-role-policy --role-name 
eksctl-casting-k8s-cluster-dev-cluster-ServiceRole-lryfbfpFDdpb  --policy-arn arn:aws:iam::aws:policy/AmazonEKSVPCResourceController
}

# Create IAM role for EKS cluster
create_iam_role "EKS-ClusterRole"

# Create IAM role for EKS nodes
create_iam_role "EKS-NodeRole"
aws iam attach-role-policy --role-name EKS-NodeRole --policy-arn arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy
aws iam attach-role-policy --role-name EKS-NodeRole --policy-arn arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly
aws iam attach-role-policy --role-name EKS-NodeRole --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess

# Output IAM role ARNs
echo "EKS Cluster Role ARN: arn:aws:iam::981666308374:role/eksctl-casting-k8s-cluster-dev-cluster-ServiceRole-lryfbfpFDdpb"
echo "EKS Node Role ARN: arn:aws:iam::981666308374:role/eksctl-casting-k8s-cluster-dev-nod-NodeInstanceRole-LEhRiTo0eJP1"
