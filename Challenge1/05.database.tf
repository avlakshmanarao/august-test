locals {
  db_instance_identifier = "${var.project}-database-${terraform.workspace}"
}

resource "random_password" "password" {
  length  = 16
  special = false
}

resource "aws_db_instance" "db_instance" {
  identifier                          = local.db_instance_identifier
  allocated_storage                   = "10"
  iops                                = "10"
  storage_type                        = "gp2"
  engine                              = "postgres"
  engine_version                      = "11.1"
  instance_class                      = "db.t2.micro"
  name                                = "sonar-db"
  username                            = "sonar"
  password                            = "sonar123"
  vpc_security_group_ids              = [aws_security_group.postgres_sg.id]
  db_subnet_group_name                = module.vpc.database_subnet_group
  publicly_accessible                 = "false"
  multi_az                            = "false"
  skip_final_snapshot                 = "true"
  storage_encrypted                   = "true"
  backup_retention_period             = "10"
  backup_window                       = "00:00-01:00"
  apply_immediately                   = "false"
  iam_database_authentication_enabled = "true"
  performance_insights_enabled        = "true"
  snapshot_identifier                 = "sonar_ss"
  parameter_group_name = "sonar_db"
  port                 = "5432"
  deletion_protection = "false"
  enabled_cloudwatch_logs_exports     = []
}



resource "aws_security_group" "postgres_sg" {
  name        = "${var.project}-postgres_sg"
  description = "Allow TCP inbound traffic on 5432"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = var.private_subnets_cidr
  }
}
