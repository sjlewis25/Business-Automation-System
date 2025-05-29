# Three-Tier AWS Architecture (Terraform)

This project deploys a fully automated three-tier architecture on AWS using Terraform. It's designed to simulate a real-world production environment, emphasizing security, scalability, and modular Infrastructure as Code (IaC) principles.

---

## Overview

The architecture includes:

- **VPC** with public and private subnets  
- **Internet Gateway** for public traffic  
- **NAT Gateway** for secure outbound access from private subnets  
- **Application Load Balancer (ALB)** to distribute traffic  
- **EC2 Instances** in private subnets behind the ALB  
- **RDS placeholder** for future database integration (optional)

All infrastructure is provisioned with Terraform and can be reused or expanded for real applications.

---

## Architecture Diagram

![Three-Tier AWS Architecture](/three-tier-architecture.png)

> *If the diagram is not visible, open or download from `/three-tier-architecture.png`.*

---

## Tools Used

- **Terraform** – Infrastructure as Code  
- **AWS VPC** – Virtual network environment  
- **EC2** – Application servers  
- **Application Load Balancer (ALB)** – Traffic routing  
- **IAM** – Access management  
- **NAT Gateway & Internet Gateway**

---

## How to Deploy

1. **Clone the repo**

```bash
git clone https://github.com/sjlewis25/Three-Tier-AWS-Architecture.git
cd Three-Tier-AWS-Architecture
```

2. **Initialize Terraform**

```bash
terraform init
```

3. **Preview changes**

```bash
terraform plan
```

4. **Apply infrastructure**

```bash
terraform apply
```

---

## Lessons Learned

- Built reusable modules for VPC, compute, and networking  
- Practiced least-privilege security with IAM and security groups  
- Automated infrastructure provisioning from scratch using Terraform  
- Gained deeper understanding of multi-tier networking in AWS

---

## File Structure

```
├── main.tf
├── variables.tf
├── outputs.tf
├── modules/
│   ├── vpc/
│   ├── ec2/
│   ├── alb/
│   └── nat/
├── diagram/
│   └── three-tier-architecture.png
```

---

## License

MIT License. Feel free to use or adapt this architecture for your own projects.

---

## Contact

Built by [Steve Lewis](https://github.com/sjlewis25)  
Feel free to connect or reach out with questions or suggestions.


