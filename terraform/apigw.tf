resource "aws_api_gateway_rest_api" "document_api" {
  name = "document-api"
}

resource "aws_api_gateway_resource" "document" {
  rest_api_id = aws_api_gateway_rest_api.document_api.id
  parent_id   = aws_api_gateway_rest_api.document_api.root_resource_id
  path_part   = "document"
}

resource "aws_api_gateway_method" "document_get" {
  rest_api_id   = aws_api_gateway_rest_api.document_api.id
  resource_id   = aws_api_gateway_resource.document.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "document_post" {
  rest_api_id   = aws_api_gateway_rest_api.document_api.id
  resource_id   = aws_api_gateway_resource.document.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "document_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.document_api.id
  resource_id             = aws_api_gateway_resource.document.id
  http_method             = aws_api_gateway_method.document_get.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.document_api.invoke_arn
}

resource "aws_api_gateway_integration" "document_post_integration" {
  rest_api_id             = aws_api_gateway_rest_api.document_api.id
  resource_id             = aws_api_gateway_resource.document.id
  http_method             = aws_api_gateway_method.document_post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.document_api.invoke_arn
}

resource "aws_api_gateway_deployment" "document_api" {
  rest_api_id = aws_api_gateway_rest_api.document_api.id
  stage_name  = "prod"
}