# Create IAM role for Lambda with a trust policy to allow Lambda service
resource "aws_iam_role" "lambda_execution_role" {
  name = "payroc_payment-role"  # Define your Lambda execution role name here

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

# IAM Policy to allow access to the payroccardsale and related tables
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
          # Allow access to the payroccardsale and related tables
          "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.current.account_id}:table/payroccardsale",
          "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.current.account_id}:table/payroccardrefund",
          "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.current.account_id}:table/payroccardvoid"
        ]
      }
    ]
  })
}

# IAM Policy to allow access to the payroccardlogs table
resource "aws_iam_policy" "dynamodb_policy_logs" {
  name        = "DynamoDBAccessPolicyLogs"
  description = "Policy to allow Lambda functions to access the payroccardlogs table"

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
          # Allow access to the payroccardlogs and related logs tables
          "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.current.account_id}:table/payroccardsalelogs",
          "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.current.account_id}:table/payroccardrefundlogs",
          "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.current.account_id}:table/payroccardvoidlogs"
        ]
      }
    ]
  })
}

# Attach the policies to the Lambda execution role
resource "aws_iam_role_policy_attachment" "lambda_dynamodb_policy_attachment" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.dynamodb_policy.arn
}

resource "aws_iam_role_policy_attachment" "lambda_dynamodb_policy_logs_attachment" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.dynamodb_policy_logs.arn
}