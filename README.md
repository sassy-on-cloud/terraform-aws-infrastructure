# Terraform AWS Infrastructure

Infrastructure as Code (IaC) project demonstrating how to provision and manage AWS infrastructure using **Terraform**.

This project builds a reproducible AWS environment consisting of a custom VPC, public subnet, Internet Gateway, route table, security group, and Ubuntu EC2 instance.

## 🎯 Project Goal

The goal of this project is to move from manually configuring AWS infrastructure to managing infrastructure through **declarative Terraform configuration**.

Instead of creating AWS resources manually through the AWS Console, the infrastructure is defined as code and can be:

* Planned before deployment
* Provisioned consistently
* Verified through Terraform state
* Modified through configuration
* Destroyed when no longer required

This project builds on the AWS and Linux experience from my previous projects and introduces **Infrastructure as Code** as the next step in my Cloud/DevOps learning journey.

---

## 🛠️ Technologies

* Terraform
* AWS
* Amazon VPC
* Amazon EC2
* AWS Security Groups
* Internet Gateway
* Route Tables
* Ubuntu 24.04 LTS
* Linux
* AWS CLI
* Git & GitHub

---

## 🏗️ Architecture

The infrastructure follows this structure:

```text
Internet
    |
    v
Internet Gateway
    |
    v
VPC (10.0.0.0/16)
    |
    v
Public Subnet (10.0.1.0/24)
    |
    +---- Route Table
    |      0.0.0.0/0 -> Internet Gateway
    |
    +---- Security Group
    |      SSH :22 -> Administrator IP
    |      HTTP :80 -> Internet
    |
    +---- Ubuntu EC2
           t3.micro
```

### AWS Resources Managed by Terraform

| Resource                | Purpose                                |
| ----------------------- | -------------------------------------- |
| VPC                     | Provides the isolated AWS network      |
| Public Subnet           | Hosts the EC2 instance                 |
| Internet Gateway        | Provides internet connectivity         |
| Route Table             | Routes internet-bound traffic          |
| Route Table Association | Connects the subnet to the route table |
| Security Group          | Controls inbound and outbound traffic  |
| EC2 Instance            | Provides the Linux server              |

For a detailed explanation of the architecture and resource relationships, see:

[`docs/architecture.md`](docs/architecture.md)

---

## 🔐 Security

Basic security controls are included in the infrastructure:

* SSH access is restricted to the administrator's public IP.
* SSH is not exposed to `0.0.0.0/0`.
* Terraform uses a dedicated IAM user with a project-specific policy.
* AWS credentials are not stored in the repository.
* Terraform state files are excluded from Git.
* Environment-specific `.tfvars` files are excluded from Git.
* No NAT Gateway is used in this learning environment to avoid unnecessary infrastructure costs.

---

## 📁 Project Structure

```text
terraform-aws-infrastructure/
│
├── README.md
├── .gitignore
│
├── terraform/
│   ├── provider.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── vpc.tf
│   ├── subnets.tf
│   ├── routes.tf
│   ├── security-groups.tf
│   └── ec2.tf
│
├── docs/
│   └── architecture.md
│
└── screenshots/
    ├── 01-project-structure.png
    ├── 02-terraform-iam-policy-json.png
    ├── 03-terraform-aws-authentication.png
    ├── 04-terraform-vpc-plan.png
    ├── 05-terraform-vpc-created.png
    ├── 06-terraform-state-verification.png
    ├── 07-terraform-subnet-plan.png
    ├── 08-terraform-subnet-created.png
    ├── 09-terraform-network-plan.png
    ├── 10-terraform-network-created.png
    ├── 11-terraform-security-group-plan.png
    ├── 12-terraform-security-group-created.png
    ├── 13-terraform-ec2-plan.png
    ├── 14-terraform-ec2-created.png
    ├── 15-terraform-infrastructure-verified.png
    ├── 16-terraform-outputs.png
    └── 17-terraform-ec2-ssh.png
```

---

## ⚙️ Terraform Workflow

The project follows the standard Terraform workflow:

```bash
terraform init
terraform validate
terraform plan
terraform apply
terraform state list
terraform output
terraform destroy
```

### 1. Initialize

```bash
terraform init
```

Downloads the required Terraform provider and initializes the working directory.

### 2. Validate

```bash
terraform validate
```

Checks whether the Terraform configuration is syntactically valid and internally consistent.

### 3. Plan

```bash
terraform plan
```

Shows the changes Terraform intends to make before modifying AWS infrastructure.

### 4. Apply

```bash
terraform apply
```

Creates or updates the infrastructure according to the Terraform configuration.

### 5. Verify

```bash
terraform state list
terraform output
terraform plan
```

These commands are used to inspect managed resources, view outputs, and confirm that the deployed infrastructure matches the configuration.

### 6. Destroy

```bash
terraform destroy
```

Removes the Terraform-managed infrastructure when it is no longer required.

---

## 📸 Project Documentation

The project includes screenshots documenting the infrastructure lifecycle:

| Stage                        | Screenshot                                 |
| ---------------------------- | ------------------------------------------ |
| Project structure            | `01-project-structure.png`                 |
| Terraform IAM policy         | `02-terraform-iam-policy-json.png`              |
| AWS authentication           | `03-terraform-aws-authentication.png`      |
| VPC planning                 | `04-terraform-vpc-plan.png`                |
| VPC creation                 | `05-terraform-vpc-created.png`             |
| Terraform state verification | `06-terraform-state-verification.png`      |
| Subnet planning              | `07-terraform-subnet-plan.png`             |
| Subnet creation              | `08-terraform-subnet-created.png`          |
| Network planning             | `09-terraform-network-plan.png`            |
| Network creation             | `10-terraform-network-created.png`         |
| Security group planning      | `11-terraform-security-group-plan.png`     |
| Security group creation      | `12-terraform-security-group-created.png`  |
| EC2 planning                 | `13-terraform-ec2-plan.png`                |
| EC2 creation                 | `14-terraform-ec2-created.png`             |
| Infrastructure verification  | `15-terraform-infrastructure-verified.png` |
| Terraform outputs            | `16-terraform-outputs.png`                 |
| EC2 SSH verification         | `17-terraform-ec2-ssh.png`                 |

These screenshots document the progression from Terraform configuration to a working AWS environment.

---

## 📚 Learning Objectives

Through this project, I practiced:

* Understanding Infrastructure as Code
* Terraform providers and configuration
* Terraform resources
* Terraform variables
* Terraform outputs
* Terraform data sources
* Terraform state
* Resource dependencies
* AWS VPC networking
* CIDR addressing
* Public subnets
* Internet Gateways
* Route tables
* Security groups
* EC2 provisioning
* SSH access
* IAM least-privilege concepts
* Terraform planning and lifecycle management

---

## 🔄 Cloud/DevOps Learning Progression

This project is part of a larger hands-on Cloud/DevOps portfolio.

```text
Project 1
Linux Server Administration
        |
        v
Project 2
Dockerized Web Application
        |
        v
Project 3
AWS Application Deployment
        |
        v
Project 4
Terraform Infrastructure as Code
        |
        v
Project 5
CI/CD + Monitoring
        |
        v
Project 6
Kubernetes Capstone
```

Each project builds on the previous one.

**Project 4 focuses specifically on Infrastructure as Code and reproducible AWS infrastructure.**

---

## 🚧 Project Status

**Core Terraform infrastructure provisioned and verified.**

Implemented:

* Terraform configuration
* Custom VPC
* Public subnet
* Internet Gateway
* Public route table
* Security group
* Ubuntu EC2 instance
* Terraform state verification
* Terraform outputs
* EC2 SSH verification
* Architecture documentation

Final lifecycle verification will include Terraform resource destruction after documentation is complete.

---

## ⚠️ Cost Awareness

This project is designed as a learning environment.

The infrastructure intentionally avoids resources such as NAT Gateways that can introduce unnecessary costs for a small learning project.

The EC2 instance and associated public IPv4 usage may incur charges depending on the AWS account's pricing and free-tier eligibility.

Resources should be destroyed when they are no longer required:

```bash
terraform destroy
```

---

## 👤 Author

**Shashwat Aryal**

Aspiring Cloud & DevOps Engineer

Cloud Computing • AWS • Linux • DevOps • Cloud Security

