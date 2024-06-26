variable "ami_id" {
  type    = map(string)
  default = {
    us-east-0 = "ami-08a0d1e16fc3f61ea"
  }
}
variable "aws_region" {
  type = string
  default = "us-east-1"
}
variable "prefix" {
  type = string
  default = "abc"
}
variable "env" {
  type = string
  default = "prod"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "instance_count" {
  type    = bool
  default = true
}
variable "security_group_rules" {
  type = map(map(string))
  default = {
    ssh = {
      from_port   = "22"
      to_port     = "22"
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }
    http = {
      from_port   = "80"
      to_port     = "80"
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }
    https = {
      from_port   = "443"
      to_port     = "443"
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  }
}
variable "private_key_path" {
  type    = string
  default = "C:/Users/sajid/OneDrive/Desktop/my-keys/terraform-us.pem"
}
variable "key_name" {
  type    = string
  default = "terraform-us"
}
variable "vpc_id" {
  type    = string
  default = "vpc-000a1c5d766ffa8f2"
}
variable "subnets" {
  type    = list(string)
  default = ["subnet-074c92da1e909f115", "subnet-007331a6eb33cc5ad"]
}