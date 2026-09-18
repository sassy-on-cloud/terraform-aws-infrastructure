variable "admin_ip" {
  description = "Public IPv4 address allowed to access the EC2 instance over SSH"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for the Terraform Project 4 server"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Existing AWS EC2 key pair name used for SSH access"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the Project 4 VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the Project 4 public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "Availability Zone for the public subnet"
  type        = string
  default     = "ap-south-1a"
}

variable "root_volume_size" {
  description = "Root EBS volume size in GB"
  type        = number
  default     = 20
}
