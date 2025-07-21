# 32co DevOps Task

This repository demonstrates a production-grade DevOps workflow for deploying a containerized Node.js CRUD API with MongoDB to AWS. It integrates **Infrastructure as Code (Terraform)**, **Docker**, **Kubernetes (EKS)**, **Helm**, and **GitHub Actions** for a robust CI/CD pipeline.

---

**terraform-nodejs-api-infra/**
  - Terraform code to provision AWS infrastructure:
    - Custom VPC with public/private subnets
    - EKS cluster for Kubernetes workloads
    - ECR for container images
    - Application Load Balancer (ALB) for ingress
    - EC2-based GitHub Actions runner for CI/CD
    - IAM policies and roles
  - See [terraform-nodejs-api-infra/README.md](./terraform-nodejs-api-infra/README.md) for full details and variable descriptions.

**nodejs-api-helm-chart/**
  - Helm chart for deploying the Node.js CRUD API and MongoDB to EKS:
    - Uses Bitnami's MongoDB Helm chart for database
    - Custom values and secrets for environment configuration
    - Ingress setup for ALB
    - Prometheus/Grafana monitoring stack (optional)
  - See [nodejs-api-helm-chart/README.md](./nodejs-api-helm-chart/README.md) for deployment and customization instructions.

**nodejs-crud-docker/**
  - Source code for a simple Node.js REST API with CRUD operations for products
  - Dockerfile and docker-compose for local development and testing
  - API endpoints for Create, Read, Update, Delete (CRUD) with MongoDB backend
  - See [nodejs-crud-docker/README.md](./nodejs-crud-docker/README.md) for API usage, endpoints, and local setup.

**.github/workflows/**
  - GitHub Actions workflow for CI/CD automation:
    - On push, builds and tests the Node.js API
    - Builds and pushes Docker image to AWS ECR
    - Deploys MongoDB and Node.js API to EKS using Helm
    - Dynamic configuration of Helm values and ingress
  - See [.github/workflows/cicd.yaml](./.github/workflows/cicd.yaml) for pipeline details.

---

## 🚀 End-to-End Workflow

1. **Infrastructure Provisioning**
   - Use Terraform to create all AWS resources: VPC, EKS, ECR, ALB, IAM, and a self-hosted GitHub Actions runner.
   - Outputs kubeconfig for EKS access and ECR repository for image storage.

2. **Application Development**
   - Develop and test the Node.js CRUD API locally using Docker Compose.
   - API supports product management with MongoDB as the backend.

3. **CI/CD Automation**
   - On code push, GitHub Actions:
     - Installs dependencies and runs tests
     - Builds Docker image and pushes to ECR
     - Updates Helm values dynamically (image tag, DB credentials, ingress)
     - Deploys MongoDB and Node.js API to EKS using Helm
     - Ensures idempotent, repeatable deployments

4. **Production Deployment**
   - Application is accessible via AWS ALB (Ingress) with DNS endpoint
   - MongoDB runs as a stateful set in its own namespace
   - Monitoring stack (Prometheus/Grafana) can be optionally deployed

5. **Cleanup**
   - Destroy all AWS resources with terraform destroy when finished

---

## 🛠️ Technologies Used

**AWS**: EKS, ECR, VPC, ALB, IAM, EC2

**Terraform**: Infrastructure as Code

**Kubernetes**: Orchestration

**Helm**: Application packaging and deployment

**Docker**: Containerization

**Node.js**: REST API backend

**MongoDB**: NoSQL database

**GitHub Actions**: CI/CD automation

**Prometheus/Grafana**: Monitoring
