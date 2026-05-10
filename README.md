# Portfolio Project 2 — Multi-Tier Cloud Application

A production-grade multi-tier cloud application deployed on AWS, featuring 
an Application Load Balancer that distributes incoming HTTP traffic across 
two EC2 instances in separate availability zones for high availability. The 
architecture follows security best practices by isolating the RDS MySQL 
database in a private subnet, unreachable from the internet, with traffic 
flow enforced through a strict security group chain.

## Architecture
Internet → ALB (public subnets, multi-AZ)
|              |
EC2 Instance 1   EC2 Instance 2
(public AZ-a)    (public AZ-b)
|              |
RDS Database (private subnet)
|
NAT Gateway (private subnet outbound)

Traffic flows in one direction through three enforced layers. The ALB 
accepts port 80 from the internet. EC2 instances only accept port 80 from 
the ALB security group — not the open internet. RDS only accepts port 3306 
from the EC2 security group. No layer can be bypassed.

## Tech Stack

- **AWS VPC** — custom isolated network with public and private subnets 
  across two availability zones
- **Application Load Balancer** — distributes traffic across EC2 instances, 
  runs health checks, removes unhealthy instances automatically
- **EC2** — two instances running Dockerized Nginx web server
- **RDS MySQL** — managed database in private subnet, infrastructure ready 
  for application integration
- **Terraform** — all infrastructure defined and provisioned as code
- **Docker** — application containerized and pushed to Docker Hub
- **GitHub Actions** — CI/CD pipeline that builds, pushes, and deploys on 
  every push to main

## CI/CD Pipeline
Push to main → GitHub Actions triggered
→ Build Docker image
→ Push to Docker Hub
→ SSH into EC2 Instance 1 → pull new image → restart container
→ SSH into EC2 Instance 2 → pull new image → restart container
→ ALB health checks confirm both instances healthy
→ Site live

## How to Deploy

1. Clone the repository
2. Add your variables to `terraform/terraform.tfvars`
3. Run the following from the `terraform/` directory:

```bash
terraform init
terraform apply
```

4. Grab the EC2 instance IPs from AWS console and update GitHub secrets 
   EC2_HOST_1 and EC2_HOST_2
5. Push any change to main to trigger the pipeline
6. Visit the load_balancer_dns output in your browser to confirm the site 
   is live

## Infrastructure Notes

- EC2 instance IPs change on every terraform apply — always update GitHub 
  secrets after applying
- RDS endpoint is marked sensitive and will not appear in terraform output
- Never commit terraform.tfvars — contains database credentials
- Run terraform destroy when done to avoid unnecessary AWS charges
