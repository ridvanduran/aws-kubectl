#!/bin/bash

create_secret() {
  kubectl create secret docker-registry aws-ecr-secret \
    --docker-server=${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com \
    --docker-username=AWS \
    --docker-password=$(aws ecr get-login-password --region ${AWS_REGION})
}

# Check if the secret exists
if kubectl get secret aws-ecr-secret; then
  # If it exists, delete it
  kubectl delete secret aws-ecr-secret
  # Create the secret again
  create_secret
else
  # If it doesn't exist, create it
  create_secret
fi