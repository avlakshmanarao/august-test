resource "aws_alb_target_group" "sonarqube_tg" {
  name        = "${var.project}-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    matcher             = "200"
    timeout             = "10"
    healthy_threshold   = "3"
    unhealthy_threshold = "2"
  }

  tags = {
    Name        = "${var.project}-tg"
  }


}


resource "aws_alb" "sonarqube-alb" {
  name            = "${var.project}"
  security_groups = [aws_security_group.sonarqube_alb_sg.id]
  subnets         = module.vpc.public_subnets

  enable_deletion_protection = false


  tags = {
    Project = var.project
  }
}


resource "aws_alb_listener" "sonar-http-listener" {
  load_balancer_arn = aws_alb.sonarqube-alb.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.sonarqube_tg.id
    type             = "forward"
  }

  depends_on = [
    aws_alb_target_group.sonarqube_tg,
    aws_alb.sonarqube-alb,
  ]
}

resource "aws_lb_target_group_attachment" "ec2-instance" {
  target_group_arn = aws_alb_target_group.sonarqube_tg.arn
  target_id        = aws_instance.sonarqube.id
  depends_on       = [aws_instance.sonarqube]
}
