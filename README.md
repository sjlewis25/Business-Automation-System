# Business Automation System (3-tier Architecture)

This project sets up secure, production-ready cloud infrastructure for a small business app using Terraform and AWS. It provisions the full backend environment needed to run a Python/Flask application backed by a MySQL database.

## What Problem Does It Solve?

Most small businesses don't have reliable infrastructure to host their internal tools or services. This project solves that by providing:

- A secure VPC with public/private subnet isolation  
- An EC2 instance to host the web app  
- A private RDS MySQL database  
- Security groups to control access  
- Remote backend support for collaboration and version control  

The infrastructure is fully automated, modular, and ready to use in real-world scenarios.

## Tech Stack

- **Terraform** for Infrastructure as Code  
- **AWS VPC** with public and private subnets  
- **AWS EC2** instance running a Python/Flask web application  
- **AWS RDS** (MySQL) for persistent database storage in private subnets  
- **AWS Application Load Balancer** for routing traffic to EC2  
- **AWS S3** for remote state storage  
- **AWS DynamoDB** for Terraform state locking  
- **Security Groups** for SSH, HTTP, and MySQL access control  

## File Structure

```
modules/
├── ec2/
├── rds/
├── security_groups/
├── vpc/
scripts/
└── user_data.sh
```

## Security Highlights

- SSH access restricted to a single trusted IP  
- RDS is isolated in private subnets with no public access  
- Security groups use least-privilege rules  
- Remote state stored in S3 with locking via DynamoDB to prevent corruption  

## Future Upgrades

- Add monitoring and logging with CloudWatch  
- Implement CI/CD pipeline for automated deployment  
- Store credentials in AWS Secrets Manager  
- Add autoscaling for EC2 instances  
- Enable VPC flow logs for auditing and diagnostics  

## Getting Started

**Requirements:**
- AWS CLI configured  
- Terraform installed  
- IAM access to provision AWS resources  

**Deploy:**
```bash
terraform init
terraform apply
```

**Teardown:**
```bash
terraform destroy
```

## Author

Steven Lewis  
GitHub: [@sjlewis25](https://github.com/sjlewis25)
