resource "aws_ecs_cluster" "sonar" {
  name = "${var.project}"

  tags = {
    type = "Challange1-Demo"
  }
}

data "template_file" "sonarqube_task_definition" {
  template = "${file("${path.module}/sonarqube.json")}"
  vars = {
      sonarqube_jdbc_username    = "sonar"
      sonarqube_jdbc_password    = "${random_password.password.result}"
      sonarqube_jdbc_url         = "jdbc:postgresql://${aws_db_instance.db_instance.endpoint}/${var.project}"
      log_group_sonarqube         = aws_cloudwatch_log_group.sonar_logs.name
    }
}

resource "aws_ecs_task_definition" "sonarqube_server" {
  family = "${var.project}"
  container_definitions    = data.template_file.sonarqube_task_definition.rendered
  network_mode             = "bridge"
  cpu    = 2048
  memory = 2048


}

resource "aws_ecs_service" "sonarqube" {

  name            = "${var.project}-service"
  task_definition = aws_ecs_task_definition.sonarqube_server.arn
  cluster         = aws_ecs_cluster.sonar.id
  desired_count   = 1

  iam_role        = "${var.project}EcsRole"

  load_balancer  {
    target_group_arn  = aws_alb_target_group.sonarqube_tg.id
    container_name = var.project
    container_port = "9000"
 }
 depends_on = [aws_alb_listener.sonar-http-listener]
}


resource "aws_cloudwatch_log_group" "sonar_logs" {
  name = var.project
}
