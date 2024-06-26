provider "aws" {
  region = var.aws_region
}
locals {
  subnet_id = ["subnet-074c92da1e909f115", "subnet-007331a6eb33cc5ad"]
  instance_type = "t2.micro"
  name =" ${var.prefix} + ${var.env} "
}
resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow SSH and HTTP, HTTPS"
  dynamic "ingress" {
    for_each = var.security_group_rules
    content {
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = [ingress.value["cidr_blocks"]]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "web_sg"
  }
}
resource "aws_instance" "web" {
count           = var.instance_count  ? 1 : 0
# ami = var.ami_id[var.aws_region]
  ami             = lookup(var.ami_id , var.aws_region, "ami-08a0d1e16fc3f61ea")
  instance_type   = var.env == "dev" ? "t2.micro" : var.env == "tst" ? "t2.medium" : "t2.large"
  security_groups = [aws_security_group.web_sg.id]
  key_name        = var.key_name
#   subnet_id = var.subnets[count.index]
#   subnet_id = element(local.subnet_id, count.index)
  connection {
    type        = "ssh"
    private_key = file(var.private_key_path)
    user        = "ec2-user"
    host        = self.public_ip
  }
#   provisioner "file" {
#     source      = "./scripts/setup.sh"
#     destination = "/tmp/setup.sh"
#   }
#   provisioner "remote-exec" {
#     inline = [
#       "chmod +x /tmp/setup.sh",
#       "/tmp/setup.sh"
#     ]
# }
  tags = {
    # Name = "web ${count.index + 1}"
    Name = local.name
  }
}
# resource "aws_lb" "web_lb" {
#   load_balancer_type = "application"
#   subnets = var.subnets
# #    dynamic "subnet_mapping" {
# #     for_each = local.subnet_id
# #     content {
# #       subnet_id = subnet_mapping.value
# #     }
#     # }
#   security_groups    = [aws_security_group.web_sg.id]
#   tags = {
#     Name = "web_lb"
#   }
# }
# resource "aws_lb_target_group" "web_tg" {
#   vpc_id   = var.vpc_id
#   protocol = "HTTP"
#   port     = 80
#   tags = {
#     Name = "web_tg"
#   }
# }
# resource "aws_lb_listener" "web_listener" {
#   load_balancer_arn = aws_lb.web_lb.arn
#   protocol          = "HTTP"
#   port              = 80
#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.web_tg.arn
#   }
# }
# resource "aws_lb_target_group_attachment" "web_tg_attachment" {
#   count            = var.instance_count
#   target_group_arn = aws_lb_target_group.web_tg.arn
#   target_id        = aws_instance.web[count.index].id
#   port = 80
# }