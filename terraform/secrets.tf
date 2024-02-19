resource "aws_secretsmanager_secret" "db_password" {
  name = "db_password"
}

resource "aws_secretsmanager_secret_version" "example" {
  secret_id     = aws_secretsmanager_secret.example.id
  secret_string = jsonencode(var.db_password)
}