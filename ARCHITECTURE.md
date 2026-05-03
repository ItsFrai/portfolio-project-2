# Portfolio Project 2 — Production-Ready AWS Architecture

## Overview
A production-grade multi-tier web application deployed on AWS using Infrastructure as Code. This project demonstrates real world cloud architecture patterns used by commercial tech companies including custom VPC networking, high availability across multiple Availability Zones, managed database services, load balancing, and automated monitoring.

## Architecture

Internet
    |
Application Load Balancer (public subnets, multi-AZ)
    |              |
EC2 Instance 1   EC2 Instance 2
(public AZ-a)    (public AZ-b)
    |              |
        RDS Database
        (private subnet)
        |
    NAT Gateway
    (private subnet outbound)

S3 Bucket - Terraform state storage
CloudWatch - monitoring and alarms

## Components

### Networking
- Custom VPC - isolated private network, CIDR 10.0.0.0/16
- Public Subnets - 2 subnets across 2 AZs for EC2 and Load Balancer
- Private Subnets - 2 subnets across 2 AZs for RDS database
- Internet Gateway - connects VPC to public internet
- NAT Gateway - allows private subnet outbound internet access

### Compute
- 2 EC2 instances - web servers in separate AZs for high availability
- Application Load Balancer - distributes traffic across both instances
- Auto-bootstrapped via user_data - installs Docker and runs application container

### Database
- RDS MySQL - managed relational database in private subnet
- Multi-AZ - automatic standby in second AZ for failover
- Private access only - only EC2 instances can connect, never public internet

### Storage
- S3 bucket - stores Terraform state file for durability and team sharing

### Monitoring
- CloudWatch alarms - CPU usage and instance health monitoring
- SNS notifications - email alerts when alarms trigger

## Security
- EC2 instances only accept traffic from Load Balancer security group
- RDS only accepts traffic from EC2 security group
- No direct public access to database
- All sensitive values stored as Terraform variables, never hardcoded

## Infrastructure as Code
- 100% provisioned with Terraform
- Split into logical files: main.tf, compute.tf, database.tf, monitoring.tf, s3.tf
- Variables defined in variables.tf, values in terraform.tfvars

## CI/CD
- GitHub Actions pipeline
- On every push: builds Docker image, pushes to Docker Hub, deploys to EC2 instances

## How To Deploy
1. Create AWS account and configure credentials
2. Clone repository
3. Navigate to terraform folder
4. Run terraform init
5. Run terraform apply
6. Visit Load Balancer DNS name shown in output
 
 
 
