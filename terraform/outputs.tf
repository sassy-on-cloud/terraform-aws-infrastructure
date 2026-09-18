output "vpc_id" {
  description = "ID of the Terraform-managed VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "ID of the Terraform-managed public subnet"
  value       = aws_subnet.public.id
}

output "security_group_id" {
  description = "ID of the Terraform-managed web security group"
  value       = aws_security_group.web.id
}

output "ec2_instance_id" {
  description = "ID of the Terraform-managed EC2 instance"
  value       = aws_instance.web.id
}

output "ec2_public_ip" {
  description = "Public IPv4 address of the Terraform-managed EC2 instance"
  value       = aws_instance.web.public_ip
}
