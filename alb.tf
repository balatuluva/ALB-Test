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
  name = "ALB-Test"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.ALB_VPC_SG.id]
  subnets = aws_subnet.ALB_VPC_Public_Subnet[*].id
#  subnets = [for subnet in aws_subnet.ALB_VPC_Public_Subnet : subnet.id]

  tags = {
    Name = "ALB-Test"
  }
}

resource "aws_lb_listener" "ALB_Test_Listener_Default" {
  load_balancer_arn = aws_lb.ALB_Test.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.TGS[0].arn
  }
}
resource "aws_lb_listener_rule" "ALB_Test_Listener_Movies" {
 listener_arn = aws_lb_listener.ALB_Test_Listener_Default.arn
 priority     = 60

 action {
   type             = "forward"
   target_group_arn = aws_lb_target_group.TGS[1].arn
 }

 condition {
   path_pattern {
     values = ["/Movies*"]
   }
 }
}

resource "aws_lb_listener_rule" "ALB_Test_Listener_Shows" {
 listener_arn = aws_lb_listener.ALB_Test_Listener_Default.arn
 priority     = 40

 action {
   type             = "forward"
   target_group_arn = aws_lb_target_group.TGS[2].arn
 }

 condition {
   path_pattern {
     values = ["/Shows*"]
   }
 }
}