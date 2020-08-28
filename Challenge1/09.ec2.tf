data "template_file" "cloud_config" {
  template = "${file("${path.module}/cloud-config.yml")}"
  vars = {
    ecs_cluster_name = "${aws_ecs_cluster.sonar.name}"
  }
}

resource "aws_iam_instance_profile" "sonar_iam_profile" {
  name = "sonar-iam-profile"
  role = "${var.project}EcsRole"
}


resource "aws_instance" "sonarqube" {
    ami                          = var.image_id
    associate_public_ip_address  = false
    availability_zone            = var.azs[0]
    iam_instance_profile         = aws_iam_instance_profile.sonar_iam_profile.id
    instance_type                = "t2.medium"
    security_groups              = []
    source_dest_check            = true
    key_name                     = "${var.project}-ec2-key"
    subnet_id                    = module.vpc.private_subnets[0]
    tenancy                      = "default"
    user_data                    = "${data.template_file.cloud_config.rendered}"
    vpc_security_group_ids       = [aws_security_group.sonarqube_alb_sg.id]


    tags = {
      project = "${var.project}"

    }
}


resource "aws_security_group" "sonarqube_alb_sg" {

  name = "sonar-alb-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     =  ["0.0.0.0/0"]
  }

 ingress {
  protocol    = "tcp"
  from_port   = 22
  to_port     = 22
  cidr_blocks     =  ["0.0.0.0/0"]
 }

 egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

}
