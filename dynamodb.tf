resource "aws_dynamodb_table" "payroc_card_sale" {
  name         = "payroccardsale"
  billing_mode = "PAY_PER_REQUEST"

  # Primary partition key
  hash_key = "transaction_id"

  # Define all the attributes
  attribute {
    name = "transaction_id"
    type = "S" # String (Partition Key)
  }

  attribute {
    name = "authorization_code"
    type = "S" # String
  }

  attribute {
    name = "card_last_four_digits"
    type = "S" # String
  }

  attribute {
    name = "card_product"
    type = "S" # String
  }

  attribute {
    name = "card_country_of_origin"
    type = "N" # Number (since it's numeric)
  }

  attribute {
    name = "expiry_date"
    type = "S" # String
  }

  attribute {
    name = "card_type"
    type = "S" # String
  }

  # Optional Global Secondary Indexes (if specific query patterns require them)
  global_secondary_index {
    name            = "AuthorizationCodeIndex"
    hash_key        = "authorization_code"
    projection_type = "ALL"
  }

  global_secondary_index {
    name            = "CardCountryIndex"
    hash_key        = "card_country_of_origin"
    projection_type = "ALL"
  }

  # Additional Global Secondary Indexes for unused attributes
  global_secondary_index {
    name            = "CardLastFourDigitsIndex"
    hash_key        = "card_last_four_digits"
    projection_type = "ALL"
  }

  global_secondary_index {
    name            = "CardProductIndex"
    hash_key        = "card_product"
    projection_type = "ALL"
  }

  global_secondary_index {
    name            = "CardTypeIndex"
    hash_key        = "card_type"
    projection_type = "ALL"
  }

  global_secondary_index {
    name            = "ExpiryDateIndex"
    hash_key        = "expiry_date"
    projection_type = "ALL"
  }

  # Point-In-Time Recovery (enabled for data recovery)
  point_in_time_recovery {
    enabled = true
  }

  tags = {
    Name = "payroccardsale"
  }
}

resource "aws_dynamodb_table" "payroc_card_refund" {
  name         = "payroccardrefund"
  billing_mode = "PAY_PER_REQUEST"

  # Primary partition key
  hash_key = "terminal_id"

  # Define all the attributes
  attribute {
    name = "terminal_id"
    type = "S" # String
  }

  attribute {
    name = "transaction_type"
    type = "S" # String
  }

  attribute {
    name = "reference"
    type = "S" # String
  }

  attribute {
    name = "amount"
    type = "N" # Number
  }

  attribute {
    name = "token"
    type = "S" # String
  }

  # Optional Global Secondary Indexes (GSI) for querying by transaction_type, reference, and token
  global_secondary_index {
    name            = "TransactionTypeIndex"
    hash_key        = "transaction_type"
    projection_type = "ALL"
  }

  global_secondary_index {
    name            = "ReferenceIndex"
    hash_key        = "reference"
    projection_type = "ALL"
  }

  global_secondary_index {
    name            = "AmountIndex"
    hash_key        = "amount"
    projection_type = "ALL"
  }

  global_secondary_index {
    name            = "TokenIndex"
    hash_key        = "token"
    projection_type = "ALL"
  }

  # Point-In-Time Recovery
  point_in_time_recovery {
    enabled = true
  }

  tags = {
    Name = "payroccardrefund"
  }
}
resource "aws_dynamodb_table" "payroc_card_void" {
  name         = "payroccardvoid"
  billing_mode = "PAY_PER_REQUEST"

  # Primary partition key
  hash_key = "transaction_id"

  # Define all the attributes
  attribute {
    name = "transaction_id"
    type = "S" # String (Partition Key)
  }

  attribute {
    name = "authorization_code"
    type = "S" # String
  }

  attribute {
    name = "card_last_four_digits"
    type = "S" # String
  }

  attribute {
    name = "card_product"
    type = "S" # String
  }

  attribute {
    name = "card_country_of_origin"
    type = "N" # Number (since it's numeric)
  }

  attribute {
    name = "expiry_date"
    type = "S" # String
  }

  attribute {
    name = "card_type"
    type = "S" # String
  }

  # Optional Global Secondary Indexes (if specific query patterns require them)
  global_secondary_index {
    name            = "AuthorizationCodeIndex"
    hash_key        = "authorization_code"
    projection_type = "ALL"
  }

  global_secondary_index {
    name            = "CardCountryIndex"
    hash_key        = "card_country_of_origin"
    projection_type = "ALL"
  }

  # Additional Global Secondary Indexes for unused attributes
  global_secondary_index {
    name            = "CardLastFourDigitsIndex"
    hash_key        = "card_last_four_digits"
    projection_type = "ALL"
  }

  global_secondary_index {
    name            = "CardProductIndex"
    hash_key        = "card_product"
    projection_type = "ALL"
  }

  global_secondary_index {
    name            = "CardTypeIndex"
    hash_key        = "card_type"
    projection_type = "ALL"
  }

  global_secondary_index {
    name            = "ExpiryDateIndex"
    hash_key        = "expiry_date"
    projection_type = "ALL"
  }

  # Point-In-Time Recovery (enabled for data recovery)
  point_in_time_recovery {
    enabled = true
  }

  tags = {
    Name = "payroccardvoid"
  }
}