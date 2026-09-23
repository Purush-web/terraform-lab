provider "aws" { region = "us-east-1" }

# 1️⃣ Create the Lambda function
resource "aws_lambda_function" "example" {
  function_name = "example-scheduled-lambda"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
  timeout       = 900
  memory_size   = 128

  filename         = "lambda_function.zip" # Path to your packaged code
  source_code_hash = filebase64sha256("lambda_function.zip")
}

# 2️⃣ IAM Role for Lambda
resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# 3️⃣ Attach basic execution policy
resource "aws_iam_role_policy_attachment" "lambda_logging" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# 4️⃣ Create EventBridge rule (event)
resource "aws_cloudwatch_event_rule" "event_rule" {
  name        = "my-lambda-event-rule"
  description = "Triggers Lambda based on specific event patterns"

  # Example: Triggers whenever an EC2 instance state changes to 'running'
  event_pattern = jsonencode({
    source      = ["aws.ec2"]
    detail-type = ["EC2 Instance State-change Notification"]
    detail = {
      state = ["running"]
    }
  })
}

# 5️⃣ Set the Lambda Function as the Rule's Target
resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.event_rule.name
  target_id = "SendToLambda"
  arn       = aws_lambda_function.example.arn
}

# 6️⃣  Explicitly Grant Permission for EventBridge to Invoke the Lambda
resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.example.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.event_rule.arn
}