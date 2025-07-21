# Terraform AWS EKS with VPC and ALB Controller For NodeJS CURD API

This Terraform project is designed to create an AWS infrastructure that includes the following components:

- **VPC (Virtual Private Cloud):** Custom VPC for isolating resources.
- **EKS Cluster (Elastic Kubernetes Service):** Managed Kubernetes cluster for containerized applications.
- **AWS Load Balancer Controller:** Deployed within the EKS cluster to manage Application Load Balancers (ALB) for Kubernetes services.
- **ECR:** Private container registry to store Docker images.
- **Runner:** EC2-based runner for CI/CD workflows.

## Prerequisites

Ensure you have the following installed and configured:

1. [Terraform](https://www.terraform.io/downloads.html) (v1.0.0 or higher)
2. AWS CLI configured with appropriate credentials and permissions
3. kubectl (Kubernetes CLI)
4. AWS IAM permissions for creating resources (VPC, EKS, IAM roles, ALB, etc.)

## Directory Structure

```
terraform-nodejs-api-infra/
├── ./policy                              # IAM Policies (JSON)
├── vpc.tf                                # VPC Module
├── cluster.tf                            # EKS Module
├── ecr.tf                                # ECR Module
├── runner.tf                             # GitHub Action Runner
├── load-balancer-controller.tf           # AWS Load Balancer Controller Setup
├── variable.tf                           # Input Variables
├── provider.tf                           # Terraform Providers
└── README.md                             # Project Documentation
```

## Features

### 1. VPC
- Creates a custom VPC with public and private subnets across multiple availability zones.
- Configures NAT Gateways for internet access to private subnets.
- Outputs subnet IDs and VPC ID for reference.

### 2. EKS Cluster
- Provisions an EKS cluster with the specified number of worker nodes.
- Configures IAM roles and policies for EKS and worker nodes.
- Outputs the kubeconfig file for cluster access.

### 3. ECR 
- Private container registry for Docker image storage.

### 4. GitHub Action Runner
- EC2-based self-hosted runner
- Integrated with GitHub for CI/CD

### 5. AWS Load Balancer Controller
- Installs the AWS Load Balancer Controller using Helm.
- Configures necessary IAM roles and policies for ALB integration.
- Supports the creation of ALBs for Kubernetes Ingress resources.

## Usage

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Rfulmali/32co-DevOps-Task.git
   cd terraform-nodejs-api-infra
   ```

2. **Customize variables:**
   Update `variables.tf` or create a `terraform.tfvars` file with your specific values.

3. **Initialize Terraform:**
   ```bash
   terraform init
   ```

4. **Plan the infrastructure:**
   ```bash
   terraform plan
   ```

5. **Apply the configuration:**
   ```bash
   terraform apply
   ```

6. **Access EKS Cluster:**
   Retrieve the kubeconfig output to access the EKS cluster:
   ```bash
   rm ~/.kube/config
   aws eks --region <region> update-kubeconfig --name <cluster-name>
   ```

7. **Verify EKS cluster is running or not**
   Ensure the nodes are running by using kubectl command:
   ```bash
   kubectl get node 
   ```

8. **Uncomments load-balancer-controller.tf file and helm, kubectl providers from providers.tf file**

9. **Initialize Terraform:**
   ```bash
   terraform init
   ```
10. **Plan the infrastructure:**
   ```bash
   terraform plan
   ```

11. **Apply the configuration:**
   ```bash
   terraform apply
   ```

8. **Setup Runner VM**
   ```bash
   mkdir actions-runner && cd actions-runner
   curl -o actions-runner-linux-x64-2.326.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.326.0/actions-runner-linux-x64-2.326.0.tar.gz
   echo "9c74af9b4352bbc99aecc7353b47bcdfcd1b2a0f6d15af54a99f54a0c14a1de8  actions-runner-linux-x64-2.326.0.tar.gz" | shasum -a 256 -c
   tar xzf ./actions-runner-linux-x64-2.326.0.tar.gz
   
   ./config.sh --url <Repo_URL> --token <Repo_TOKEN>
   ./run.sh
   ```

## Inputs

| `Name`              | `Description`                            | `Type`         | `Default`                         |
|---------------------|------------------------------------------|----------------|-----------------------------------|
| `vpc_name`          | Name of the VPC                          | `string`       | `"main"`                          |
| `vpc_cidr`          | CIDR block for the VPC                   | `string`       | `"10.0.0.0/16"`                   |
| `azs`               | Availability Zones                       | `list(string)` | `["us-east-1a", "us-east-1b"]`    |
| `private_subnets`   | CIDR blocks for private subnets          | `list(string)` | `["10.0.0.0/19", "10.0.32.0/19"]` |
| `public_subnets`    | CIDR blocks for public subnets           | `list(string)` | `["10.0.64.0/19", "10.0.96.0/19"]`|
| `cluster_name`      | Name of the Cluster                      | `string`       | `"main"`                          |
| `region`            | AWS region                               | `string`       | `"us-east-1"`                     |
| `ami_id`            | Amazon Linux 2 AMI or Ubuntu             | `string`       | `"ami-0abcdef1234567890"`         |
| `public_key_path`   | Path to your SSH public key              | `string`       | `"~/.ssh/32co-task-key.pub"`      |
| `runner_sg_cidr`    | Your IP CIDR for SSH access              | `string`       | `"0.0.0.0/0"`                     |
| `ecr_repo_name`     | ECR Repo Name                            | `string`       | `"nodejs-crud-api"`               |

## Cleanup

To delete all the resources created by this project, run:

```bash
terraform destroy
```

---
