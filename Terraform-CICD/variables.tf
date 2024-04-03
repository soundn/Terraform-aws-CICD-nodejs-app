variable "ami" {
  default = "ami-0914547665e6a707c"  # Replace with your preferred AMI
}

variable "instance_type" {
  default = "t3.micro"
}

variable "key_name" {
  default = "newaws"  # Replace with your existing key pair name
}

variable "vpc_security_group_ids" {
  type = list(string)
  default = ["sg-0cf0343ab84d9ef1b"]  # Replace with your security group IDs
}
