#!/bin/bash

# Variables
BUCKET_NAME="casting-dev-bucket-$(date +%s)"
REGION="us-west-1"
POLICY='{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "Statement1",
			"Effect": "Allow",
			"Action": [
				"s3:GetObject",
				"s3:PutObject"
			],
			"Resource": [
				"arn:aws:s3:::casting-dev-bucket/*"
			]
		}
	]
}
}'
# Create S3 bucket
aws s3api create-bucket --bucket casting-dev-bucket --region us-west-1 --create-bucket-configuration LocationConstraint=us-west-1

# Apply bucket policy from the variable
aws s3api put-bucket-policy --bucket casting-dev-bucket --policy "$POLICY"
