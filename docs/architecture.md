# Project 4 Architecture

## Overview

This project demonstrates **Infrastructure as Code (IaC)** using Terraform to provision and manage AWS infrastructure.

The infrastructure consists of a custom VPC, public subnet, Internet Gateway, public route table, security group, and Ubuntu EC2 instance.

The objective is to demonstrate how cloud infrastructure can be defined as code, provisioned reproducibly, verified through Terraform state, and destroyed when no longer required.

---

## Architecture

```text
                              Internet
                                  |
                                  v
                       +----------------------+
                       |   Internet Gateway    |
                       +----------------------+
                                  |
                                  v
        +--------------------------------------------------+
        |              VPC: 10.0.0.0/16                    |
        |                                                  |
        |   +------------------------------------------+   |
        |   |        Public Route Table                |   |
        |   |        0.0.0.0/0 -> IGW                  |   |
        |   +---------------------+--------------------+   |
        |                         |                        |
        |                         v                        |
        |   +------------------------------------------+   |
        |   | Public Subnet: 10.0.1.0/24              |   |
        |   | Availability Zone: ap-south-1a          |   |
        |   |                                          |   |
        |   |   +----------------------------------+   |   |
        |   |   | Security Group                  |   |   |
        |   |   |                                  |   |   |
        |   |   | SSH :22 -> Administrator IP     |   |   |
        |   |   | HTTP :80 -> Internet            |   |   |
        |   |   +----------------+-----------------+   |   |
        |   |                    |                     |   |
        |   |                    v                     |   |
        |   |   +----------------------------------+   |   |
        |   |   | Ubuntu EC2                       |   |   |
        |   |   | t3.micro                         |   |   |
        |   |   | Public IPv4 enabled              |   |   |
        |   |   +----------------------------------+   |   |
        |   +------------------------------------------+   |
        |                                                  |
        +--------------------------------------------------+
```

The VPC provides the overall network boundary. The public subnet is contained within the VPC, while the route table and Internet Gateway provide internet connectivity.

The security group controls traffic reaching the EC2 instance.

---

## AWS Components

### VPC

* CIDR: `10.0.0.0/16`
* DNS support enabled
* DNS hostnames enabled
* Managed by Terraform

The VPC provides an isolated virtual network for the infrastructure.

### Public Subnet

* CIDR: `10.0.1.0/24`
* Availability Zone: `ap-south-1a`
* Public IPv4 address assignment enabled
* Managed by Terraform

The subnet is configured as a public subnet because its route table provides a route to the Internet Gateway.

### Internet Gateway

The Internet Gateway is attached to the VPC and provides connectivity between the VPC and the internet.

### Public Route Table

The public route table contains the following default route:

```text
0.0.0.0/0 -> Internet Gateway
```

The route table is associated with the public subnet.

This allows resources in the public subnet with public IPv4 addresses to communicate with the internet.

### Security Group

The security group acts as a virtual firewall for the EC2 instance.

#### Inbound Rules

| Protocol | Port | Source           | Purpose            |
| -------- | ---: | ---------------- | ------------------ |
| TCP      |   22 | Administrator IP | SSH administration |
| TCP      |   80 | `0.0.0.0/0`      | HTTP web traffic   |

SSH access is restricted to the administrator's public IP rather than being exposed to the entire internet.

Outbound traffic is allowed.

### EC2 Instance

The EC2 instance is provisioned inside the Terraform-managed public subnet.

* Operating System: Ubuntu 24.04 LTS
* Architecture: x86_64
* Instance type: configurable through Terraform
* Root volume: configurable through Terraform
* Existing EC2 key pair used for SSH access
* Public IPv4 address enabled

---

## Terraform Resource Relationships

Terraform manages the infrastructure through dependencies between resources.

```text
aws_vpc.main
    |
    +----> aws_subnet.public
    |          |
    |          +----> aws_route_table_association.public
    |          |
    |          +----> aws_instance.web
    |
    +----> aws_internet_gateway.main
    |          |
    |          +----> aws_route_table.public
    |
    +----> aws_security_group.web
               |
               +----> aws_instance.web
```

Terraform determines the correct creation order from these resource references.

For example:

```hcl
subnet_id = aws_subnet.public.id
```

means the EC2 instance references the public subnet and therefore depends on that subnet being available.

Similarly, the security group references the VPC:

```hcl
vpc_id = aws_vpc.main.id
```

This allows Terraform to understand the relationships between resources and construct the required dependency graph.

---

## Terraform State

Terraform maintains a **state file** to track the resources it manages.

The state allows Terraform to compare the desired configuration with the infrastructure currently deployed in AWS.

The following command was used to verify the infrastructure after provisioning:

```bash
terraform plan
```

The final verification returned:

```text
No changes. Your infrastructure matches the configuration.
```

This confirmed that the deployed infrastructure matched the Terraform configuration.

The Terraform state file is excluded from Git using `.gitignore`.

---

## Configuration and Variables

The project uses Terraform variables for values that may change between environments.

Examples include:

* VPC CIDR
* Public subnet CIDR
* Availability Zone
* EC2 instance type
* Root volume size
* EC2 key pair name
* Administrator IP address

Environment-specific values are kept outside the Git repository.

This makes the Terraform configuration more reusable and prevents environment-specific configuration from being hard-coded into resource definitions.

---

## Security Considerations

The project applies several basic security practices:

* SSH access is restricted to a specific administrator IP.
* SSH is not exposed to `0.0.0.0/0`.
* Terraform uses a dedicated IAM user with a project-specific policy.
* Terraform credentials are not stored in the repository.
* Terraform state files and variable files are excluded from Git.
* No NAT Gateway is used in this learning environment to avoid unnecessary infrastructure costs.

The infrastructure is intentionally kept simple for learning purposes while demonstrating basic network and access-control concepts.

---

## Current Scope

The current infrastructure focuses on **AWS networking and EC2 provisioning with Terraform**.

The project currently demonstrates:

* Terraform configuration
* Terraform provider setup
* Variables
* Data sources
* Terraform state
* AWS VPC
* Public subnet
* Internet Gateway
* Route table
* Security group
* EC2 provisioning
* SSH connectivity
* Infrastructure verification
* Terraform lifecycle management

Application deployment, Docker installation, CI/CD, monitoring, and Kubernetes are covered by other projects in the Cloud/DevOps learning roadmap.

---

## Terraform Workflow

The infrastructure can be managed using the following Terraform workflow:

```bash
terraform init
terraform validate
terraform plan
terraform apply
terraform state list
terraform output
terraform destroy
```

The project demonstrates the Infrastructure as Code lifecycle:

```text
Write Configuration
        |
        v
terraform init
        |
        v
terraform validate
        |
        v
terraform plan
        |
        v
terraform apply
        |
        v
Verify Infrastructure
        |
        v
terraform destroy
```

This workflow allows the infrastructure to be created, inspected, verified, and removed using the same Terraform configuration.

