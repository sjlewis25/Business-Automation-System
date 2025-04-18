# Three-Tier AWS Architecture

## Overview
This project demonstrates a scalable, secure three-tier web application architecture on AWS. It uses Amazon EC2 instances for the web and application tiers, an Amazon RDS MySQL instance for the database tier, and an Application Load Balancer (ALB) to distribute traffic efficiently. The project is designed with best practices for security, high availability, and scalability.

## Prerequisites
- **AWS Account**: Ensure you have an AWS account with the necessary permissions.
- **AWS CLI**: Installed and configured on your machine.
- **Terraform**: Installed on your local machine.

## Setup Instructions

1. **Clone the repository**:
    ```bash
    git clone https://github.com/sjlewis25/Three-Tier-AWS-Architecture.git
    cd Three-Tier-AWS-Architecture
    ```

2. **Configure your AWS CLI** (if not done already):
    ```bash
    aws configure
    ```

3. **Initialize Terraform**:
    ```bash
    terraform init
    ```

4. **Apply Terraform to create the resources**:
    ```bash
    terraform apply
    ```

5. **Confirm the changes** by typing `yes` when prompted.

## Usage
After the deployment is complete, access your web application through the following URL:
- `http://<your-ALB-DNS-name>.amazonaws.com`

## Security Best Practices
- **VPC**: Public subnet for the web tier, private subnets for the app and database tiers.
- **Security Groups**: Restrict inbound and outbound traffic to only what's necessary.
- **IAM Roles**: Ensure proper least-privilege permissions.

## Cost Optimization
- Use **EC2 Spot Instances** for non-production environments to reduce cost.
- Choose **RDS Reserved Instances** for steady workloads to save on cost.

## CI/CD Pipeline
- A **CI/CD pipeline** is set up using **GitHub Actions** to automatically deploy infrastructure changes when pushing to the repository.

## Monitoring and Alerts
- **CloudWatch Alarms** are configured to monitor EC2 instance health and RDS performance.
- Logs are stored in **CloudWatch Logs** for auditing and troubleshooting.

## Contributing
To contribute:
1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Submit a pull request with a detailed description of the changes.

