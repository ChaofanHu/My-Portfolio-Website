variable "access_key" {
  
}

variable "secret_key" {
  
}
variable "cidr_block" {
  
}
variable "env_prefix" {
  
}
variable "my_ip" {
  
}
variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.101.0/24"]
}
variable "my_arn" {
  type = list(string)
}
variable "availability_zone" {
  
}
variable "instance_type" {
  
}