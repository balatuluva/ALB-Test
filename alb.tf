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

resource "aws_lb" "ALB_Test" {
  name = "ALB_Test"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.ALB_VPC_SG.id]
  subnets = aws_subnet.ALB_VPC_Public_Subnet[*].id
#  subnets = [for subnet in aws_subnet.ALB_VPC_Public_Subnet : subnet.id]

  tags = {
    Name = "ALB-Test"
  }
}

resource "aws_lb_listener" "ALB_Test_Listener" {
  load_balancer_arn = aws_lb.ALB_Test.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.TGS[0].arn
  }
}

#resource "aws_lb_listener_rule" "rule_b" {
#  listener_arn = aws_lb_listener.my_alb_listener.arn
#  priority     = 60
#
#  action {
#    type             = "forward"
#    target_group_arn = aws_lb_target_group.my_tg_b.arn
#  }
#
#  condition {
#    path_pattern {
#      values = ["/images*"]
#    }
#  }
#}
#
#resource "aws_lb_listener_rule" "rule_c" {
#  listener_arn = aws_lb_listener.my_alb_listener.arn
#  priority     = 40
#
#  action {
#    type             = "forward"
#    target_group_arn = aws_lb_target_group.my_tg_c.arn
#  }
#
#  condition {
#    path_pattern {
#      values = ["/register*"]
#    }
#  }
#}