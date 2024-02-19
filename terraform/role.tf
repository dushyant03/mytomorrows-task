resource "aws_iam_role" "lambda_service" {
  name               = "${var.application_deployment_account}-role-document-handler"
  assume_role_policy = data.aws_iam_policy_document.service_trust.json
  description        = "service role for Lambda."
}

data "aws_iam_policy_document" "service_trust" {
  statement {
    principals {
      type        = "Service"
      identifiers = "lambda.amazonaws.com"
    }

    actions = [
      "sts:AssumeRole"
    ]
  }
}

resource "aws_iam_role_policy_attachment" "lambda_service" {
  role       = aws_iam_role.lambda_service.name
  policy_arn = aws_iam_policy.lambda_service.arn
}

resource "aws_iam_policy" "lambda_service" {

  name        = "${var.application_deployment_account}-policy-document-handler"
  description = "IAM policy for access to the kubecost Spot instance feed S3 bucket."
  policy      = data.aws_iam_policy_document.lambda_service.json
}

data "aws_iam_policy_document" "lambda_service" {

  policy_id = "ReadWrite"

  statement {
    sid    = "AllowBucketAccess"
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = ["arn:aws:logs:*:*:*"
    ]
  }

  statement {
    sid    = "AllowBucketObjectAccess"
    effect = "Allow"

    actions = [
      "s3:PutObject*",
      "s3:GetObject*",
      "s3:DeleteObject*",
      "s3:ListBucket"
    ]

    resources = ["arn:aws:s3:::${aws_s3_bucket.document_api.bucket}/*"
    ]
  }

  statement {
    sid    = "AllowLambdaAccess"
    effect = "Allow"

    actions = [
      "lambda:InvokeFunction"
    ]

    resources = [aws_lambda_function.document_api.arn]
  }
}



