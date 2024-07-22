#!/bin/bash

# Variables
CLUSTER_NAME="casting-k8s-cluster-dev"
REGION="us-west-1"
NODE_TYPE="t3.medium"
NODE_COUNT=3

# Create EKS cluster
eksctl create cluster \
  --name $CLUSTER_NAME \
  --region $REGION \
  --nodegroup-name standard-workers \
  --node-type $NODE_TYPE \
  --nodes $NODE_COUNT \
  --nodes-min 1 \
  --nodes-max 4 \
  --managed
