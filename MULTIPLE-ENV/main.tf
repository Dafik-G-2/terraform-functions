provider "aws" {
    region = "ap-south-1"
    profile = var.profile
}
resource "aws_instance" "my-instance" {
  ami = var.ami_id
  instance_type = var.instance_type
  tags = {
    Name = "my-instance-${terraform.workspace}"
    Owner = "Dafik"
  }
}
resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "foo"
  password             = var.password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
}