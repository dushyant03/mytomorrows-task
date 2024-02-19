resource "aws_db_instance" "mysql" {
  identifier             = "${var.application_deployment_account}-document-handler"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  username               = "admin"
  password               = aws_secretsmanager_secret_version.db_password.secret_string
  multi_az               = true
  publicly_accessible    = false
  skip_final_snapshot    = true
  db_subnet_group_name   = "mydb-subnet-group"
  vpc_security_group_ids = aws_security_group.mysql.ids
}