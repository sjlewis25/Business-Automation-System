# Business Automation System (AWS 3-Tier Architecture)

## Project Description

The Business Automation System is a cloud-based infrastructure project built to support a small-to-medium business backend. It provisions a secure, modular, and production-ready 3-tier architecture using AWS and Terraform. The system hosts a Python/Flask application with a MySQL database and includes CI/CD, Secrets Management, centralized logging, and monitoring.

## What Does It Do?

- Provisions AWS infrastructure using Terraform (VPC, EC2, RDS, Security Groups)
- Deploys a Flask application on an EC2 instance using a remote deploy script
- Secures and retrieves credentials from AWS Secrets Manager
- Uses GitHub Actions for CI/CD automation
- Enables monitoring through AWS CloudWatch Agent
- Stores Terraform remote state in S3 with DynamoDB state locking

## Why Is It Useful?

Most small businesses lack the resources to implement secure, scalable infrastructure. This project demonstrates how to:
- Deploy real-world cloud infrastructure using infrastructure-as-code
- Secure workloads using IAM, private subnets, and least-privilege access
- Automate deployments using CI/CD best practices
- Monitor logs and system health using built-in AWS tools
It serves as both a production-ready baseline and a learning tool for cloud engineers.

## Tech Stack

- **Infrastructure**: Terraform (IaC), AWS (VPC, EC2, RDS, S3, IAM, CloudWatch)
- **Application Layer**: Python, Flask, Gunicorn
- **Database**: Amazon RDS (MySQL)
- **Secrets Management**: AWS Secrets Manager
- **Logging & Monitoring**: AWS CloudWatch
- **CI/CD**: GitHub Actions

## File Structure

```
modules/
├── ec2/
├── rds/
├── security_groups/
├── vpc/
scripts/
└── user_data.sh
.github/workflows/
└── ci-cd.yaml
monitoring.tf
main.tf
variables.tf
outputs.tf
terraform.tfvars
```

## How to Install and Run the Project

### Prerequisites
- AWS CLI installed and configured
- Terraform installed (v1.8+)
- SSH key pair (private key stored as GitHub secret)
- AWS IAM user/role with permissions to manage infrastructure
- GitHub repository secrets configured:
  - `EC2_PUBLIC_IP`
  - `EC2_SSH_KEY`

### Steps to Deploy

1. **Initialize Terraform and Apply**
   ```
   terraform init
   terraform plan
   terraform apply
   ```

2. **Push App Changes to Trigger CI/CD**
   ```
   git add .
   git commit -m "Deploy update"
   git push origin main
   ```

3. **Verify Application**
   - Access your Flask app in the browser using the EC2 public IP
   - Confirm database access and log ingestion to CloudWatch

4. **Destroy Infrastructure**
   ```
   terraform destroy
   ```

## Lessons Learned

- How to build reusable and modular Terraform infrastructure
- The importance of remote state management and locking for team collaboration
- How to restrict access using IAM roles, instance profiles, and security groups
- Integration of GitHub Actions for automated deployment pipelines
- Secure secret handling using AWS Secrets Manager
- Using CloudWatch Agent for centralized log collection and system metrics

---

## Author

**Steven Lewis**  
GitHub: [@sjlewis25](https://github.com/sjlewis25)
