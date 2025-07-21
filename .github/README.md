# CI/CD Workflow: Build, Push to ECR, Deploy to EKS

This GitHub Actions workflow automates the process of testing, building, pushing a Docker image to Amazon ECR, and deploying a Node.js CRUD API to an EKS cluster using Helm.

## Workflow Overview

**Runs on branch:** main

**Jobs:**
  - build-test-push: Installs dependencies, builds, and pushes Docker image to ECR.
  - deploy-to-eks: Deploys the application to EKS using Helm, after building and pushing the image.

## Trigger

The workflow is triggered on every push to the main branch.

## Jobs and Steps

### 1. build-test-push

**Runs on:** self-hosted runner

**Steps:**
  - Checkout source code
  - Set up Node.js 18
  - Install Node.js dependencies (npm install in nodejs-crud-docker)
  - Install Docker
  - Configure AWS credentials
  - Login to Amazon ECR
  - Set dynamic image tag (using short SHA)
  - Set image URI
  - Build and push Docker image to ECR

### 2. deploy-to-eks

**Needs:** build-test-push
**Runs on:** self-hosted runner

**Steps:**
  - Checkout code
  - Install unzip and AWS CLI
  - Configure AWS credentials
  - Update kubeconfig for EKS
  - Install Helm
  - Deploy MongoDB via Helm (idempotent)
  - Install yq (YAML processor)
  - Set IMAGE_URL and IMAGE_TAG in environment
  - Update values.yaml dynamically with image and DB credentials
  - Update Ingress annotations in values.yaml
  - Deploy Node.js CRUD API via Helm

## Required Secrets
The following secrets must be set in your GitHub repository:

```
AWS_ACCESS_KEY_ID: AWS access key for ECR/EKS
AWS_SECRET_ACCESS_KEY: AWS secret key
MONGODB_ROOT_PASSWORD: MongoDB root password
MONGODB_USERNAME: MongoDB username
MONGODB_PASSWORD: MongoDB user password
MONGODB_DATABASE: MongoDB database name
``` 
## Required Environment Variables
Set in the workflow or as repository variables:

```
AWS_REGION: AWS region (default: us-east-1)
IMAGE_REPO_NAME: ECR repository name (default: nodejs-crud-api)
CLUSTER_NAME: EKS cluster name (default: main)
```

## Notes
The workflow expects a self-hosted runner with permissions to install Docker, AWS CLI, and Helm.
MongoDB is deployed via the Bitnami Helm chart in the mongodb namespace.
The Node.js API is deployed via a custom Helm chart in nodejs-api-helm-chart.
The workflow dynamically updates image tags and database credentials in the Helm values file before deployment.
Update Ingress annotations with the public subnet ID's (customize as needed).

## Customization
Update the branch name in the on.push.branches section if you use a different branch.
Adjust AWS region, ECR repo, or EKS cluster name as needed.
Modify Helm values or Ingress settings in the workflow to match your infrastructure.
