resource "aws_lb_target_group" "TGS" {
  count       = length(var.TGS)
  name        = element(var.TGS, count.index)
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.ALB_VPC.id

  tags = {
    Name = element(var.TGS, count.index)
  }
}

resource "aws_lb_target_group_attachment" "TG_Attachments" {
  count = length(var.TGS)
  target_group_arn = aws_lb_target_group.TGS[count.index].arn
  target_id        = aws_instance.ALB_EC2[count.index].id
  port = 80
}

