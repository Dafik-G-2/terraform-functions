variable "ami_id" {
  type = string
#   default = "ami-04f8d7ed2f1a54b14"
  }
variable "instance_type" {
  type = string
  default = "t2.micro"
}
variable "profile" {
  type = string
  default = ""
}
variable "password" {
  default = "abc-password"
  type = string
  sensitive = true
}