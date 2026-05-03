variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name used for tagging and naming resources"
  default     = "portfolio-project-2"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "db_username" {
  description = "Database master username"
  default     = "admin"
}

variable "db_password" {
  description = "Database master password"
  sensitive   = true
}

variable "db_name" {
  description = "Database name"
  default     = "appdb"
}

variable "alert_email" {
  description = "Email address for CloudWatch alarm notifications"
  default     = "your-email@gmail.com"
}
