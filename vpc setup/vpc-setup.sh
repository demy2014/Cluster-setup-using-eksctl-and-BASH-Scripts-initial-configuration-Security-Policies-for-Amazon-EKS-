#!/bin/bash

# Variables
VPC_CIDR_BLOCK="10.0.0.0/16"
REGION="us-west-1"

# Create VPC
VPC_ID=$(aws ec2 create-vpc --cidr-block $VPC_CIDR_BLOCK --region $REGION --query 'Vpc.VpcId' --output text)

# Create Subnets
SUBNET_ID_1=$(aws ec2 create-subnet --vpc-id $VPC_ID --cidr-block 10.0.1.0/24 --availability-zone $REGION"a" --region $REGION --query 'Subnet.SubnetId' --output text)
SUBNET_ID_2=$(aws ec2 create-subnet --vpc-id $VPC_ID --cidr-block 10.0.2.0/24 --availability-zone $REGION"b" --region $REGION --query 'Subnet.SubnetId' --output text)

# Create Internet Gateway
IGW_ID=$(aws ec2 create-internet-gateway --region $REGION --query 'InternetGateway.InternetGatewayId' --output text)
aws ec2 attach-internet-gateway --vpc-id $VPC_ID --internet-gateway-id $IGW_ID --region $REGION

# Create Route Table
ROUTE_TABLE_ID=$(aws ec2 create-route-table --vpc-id $VPC_ID --region $REGION --query 'RouteTable.RouteTableId' --output text)
aws ec2 create-route --route-table-id $ROUTE_TABLE_ID --destination-cidr-block 0.0.0.0/0 --gateway-id $IGW_ID --region $REGION

# Associate Route Table with Subnets
aws ec2 associate-route-table --subnet-id $SUBNET_ID_1 --route-table-id $ROUTE_TABLE_ID --region $REGION
aws ec2 associate-route-table --subnet-id $SUBNET_ID_2 --route-table-id $ROUTE_TABLE_ID --region $REGION

# Output VPC and Subnet IDs
echo "VPC ID: $VPC_ID"
echo "Subnet 1 ID: $SUBNET_ID_1"
echo "Subnet 2 ID: $SUBNET_ID_2"
