resource "aws_instance" "ALB_EC2" {
  count = length(var.ALB_VPC_Private_Subnet)
  ami = "ami-0f9de6e2d2f067fca"
  availability_zone = element(var.azs, count.index)
  instance_type = "t2.micro"
  key_name = var.key_name
  subnet_id = var.ALB_VPC_Private_Subnet[count.index]
  vpc_security_group_ids = ["${aws_security_group.ALB_VPC_SG.id}"]
  associate_public_ip_address = false
  iam_instance_profile = "Delete-Later"
  user_data = var.user_data

  tags = {
    Name = "ALB-${count.index+1}"
  }
}