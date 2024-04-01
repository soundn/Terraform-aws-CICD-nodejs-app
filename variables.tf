variable "ami" {
  default = "ami-0885b1f6bd170450c"  # Replace with your preferred AMI
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "your-key-name"  # Replace with your existing key pair name
}

variable "vpc_security_group_ids" {
  type = list(string)
  default = ["sg-12345678"]  # Replace with your security group IDs
}
