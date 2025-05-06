resource "aws_instance" "ALB_EC2" {
  count = length(var.ALB_VPC_Private_Subnet)
  ami = "ami-0f9de6e2d2f067fca"
  availability_zone = element(var.azs, count.index)
  instance_type = "t2.micro"
  key_name = var.key_name
  subnet_id = aws_subnet.ALB_VPC_Private_Subnet[count.index].id
  vpc_security_group_ids = ["${aws_security_group.ALB_VPC_SG.id}"]
  associate_public_ip_address = false
  iam_instance_profile = "Delete-Later"
  user_data = var.user_data

  tags = {
    Name = "ALB-${count.index+1}"
  }
}

#locals {
#  user_data_scripts = [
#    var.homepage_user_data,
#    var.movies_user_data,
#    var.shows_user_data
#  ]
#}
#user_data = local.user_data_scripts[count.index]