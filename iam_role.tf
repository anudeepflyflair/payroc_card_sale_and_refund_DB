resource "aws_iam_role" "lambda_execution_role" {
  name = "payroc_payment-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_dynamodb_policy" {
  name = "lambda_dynamodb_policy"
  role = aws_iam_role.lambda_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:UpdateItem",
          "dynamodb:Query",
          "dynamodb:Scan"
        ],
        Effect   = "Allow",
        Resource = [
          "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.current.account_id}:table/payroccardsale",
          "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.current.account_id}:table/payroccardrefund",
          "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.current.account_id}:table/payroccardvoid"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_dynamodb_policy_logs" {
  name = "lambda_dynamodb_policy_logs"
  role = aws_iam_role.lambda_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:UpdateItem",
          "dynamodb:Query",
          "dynamodb:Scan"
        ],
        Effect   = "Allow",
        Resource = [
          "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.current.account_id}:table/payroccardsalelogs",
          "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.current.account_id}:table/payroccardrefundlogs",
          "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.current.account_id}:table/payroccardvoidlogs"
        ]
      }
    ]
  })
}