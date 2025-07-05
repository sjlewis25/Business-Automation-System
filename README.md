# Business Automation System on AWS

A fully deployable, three-tier architecture built with AWS and Terraform to automate common small business operations such as task tracking, order processing, and backend workflow management.

---

## Why This Project Matters

Many small businesses still rely on spreadsheets, email chains, or manual tracking boards to manage tasks and customer orders. This results in wasted time, human error, and poor visibility into business workflows.

This project provides an infrastructure blueprint that businesses or developers can use to deploy a scalable, secure, and automated system that replaces those manual processes with a structured cloud-based solution.

---

## What This Project Does

This system creates a production-ready environment using a traditional 3-tier architecture:

- **Frontend Tier**: A public EC2 instance serves as the entry point for users to submit tasks or orders via a web interface.
- **Application Tier**: A private EC2 instance runs a Flask-based backend to process and route incoming requests.
- **Database Tier**: Amazon RDS (MySQL) stores submitted data with durability and query access.

All components are provisioned using Terraform for repeatable and automated deployments.

---

## Use Cases

You can adapt this system to:

- Automate intake of service requests, work orders, or customer submissions
- Track internal tasks or job statuses across teams
- Serve as the backend for a lightweight business app or web form
- Teach DevOps fundamentals using real infrastructure examples

---

## How to Deploy

### Prerequisites

- AWS account with admin-level credentials
- Terraform installed locally
- SSH key pair available

### Steps

1. Clone the repo:

   ```bash
   git clone https://github.com/sjlewis25/Business-Automation-System.git
   cd Business-Automation-System
   ```

2. Configure your variables in `terraform.tfvars` or directly in `main.tf`.

3. Initialize and apply Terraform:

   ```bash
   terraform init
   terraform apply
   ```

4. After deployment, SSH into the frontend EC2 instance to access the app.

---

## Architecture Overview

AWS Services Used:

- **Networking**: VPC, Subnets, Route Tables, NAT Gateway, Internet Gateway
- **Compute**: EC2 with Launch Templates and Auto Scaling
- **Database**: RDS (MySQL)
- **Security**: IAM Roles, Security Groups
- **Monitoring**: CloudWatch Logs

---

## Project Structure

```
.
├── app.py                  # Backend logic using Flask
├── ec2_user_data.sh        # Bootstraps EC2 instances
├── main.tf                 # Terraform infrastructure config
├── outputs.tf              # Outputs for EC2 and RDS
├── setup.sh                # Local setup script
├── README.md               # Project documentation
```

---

## Future Enhancements

- Integrate with [Serverless Task API](https://github.com/sjlewis25/serverless-task-api)
- Store uploaded documents in Amazon S3
- Add CI/CD deployment via GitHub Actions

---

## License

This project is open-source and available for anyone to reuse, modify, or extend under the MIT license.

---

## Author

Steven Lewis  
GitHub: [https://github.com/sjlewis25](https://github.com/sjlewis25)


