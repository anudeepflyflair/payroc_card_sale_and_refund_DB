# Get the AWS caller identity
data "aws_caller_identity" "current" {}

# Create IAM role for Lambda with a trust policy to allow Lambda service
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

# IAM Policy to allow access to the payroccardsale table
resource "aws_iam_policy" "dynamodb_policy" {
  name        = "DynamoDBAccessPolicy"
  description = "Policy to allow Lambda functions to access the payroccardsale table"

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
          "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.current.account_id}:table/payroccardsalelogs",
          "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.current.account_id}:table/payroccardrefund",
          "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.current.account_id}:table/payroccardrefundlogs",
          "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.current.account_id}:table/payroccardvoid",
          "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.current.account_id}:table/payroccardvoidlogs"
        ]
      },
      {
        Action = "dynamodb:PutItem",
        Effect = "Allow",
        Resource = "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.current.account_id}:table/payroccardsale"
      }
    ]
  })
}

# Attach the policy to the Lambda execution role
resource "aws_iam_role_policy_attachment" "lambda_dynamodb_policy_attachment" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.dynamodb_policy.arn
}
