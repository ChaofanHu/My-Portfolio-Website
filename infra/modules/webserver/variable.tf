variable "availability_zone" {
  
}
variable "env_prefix" {
  
}
variable "my_ip" {
  
}
variable "aws_ami" {
  
}

variable "instance_type" {
  
}
variable "public_key_location" {
    
}
variable "vpc_id" {
  
}
variable "subnet_id" {
  
}
variable "domain_name" {
  description = "The domain name for the Route 53 record"
  type        = string
  default     = "chaofanbox.com"
}