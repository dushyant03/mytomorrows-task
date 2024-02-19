resource "aws_lambda_function" "document_api" {
  function_name    = "${var.application_deployment_account}-document-api"
  role             = aws_iam_role.lambda_service.arn
  handler          = "document_api.handler"
  runtime          = "python3.8"
  filename         = "document_api.zip" #The zip file needs to be present in the repo
  source_code_hash = filebase64sha256("document_api.zip")
  timeout          = 60
  memory_size      = 256

  environment {
    variables = {
      MYSQL_HOST     = resource.mysql.address
      MYSQL_DATABASE = resource.mysql.db_name
      MYSQL_USER     = resource.mysql.username
      MYSQL_PASSWORD = aws_secretsmanager_secret_version.db_password.secret_string
      S3_BUCKET      = module.s3_bucket.id
    }
  }
}