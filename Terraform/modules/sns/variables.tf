variable "sns_topic_name" {
  description = "The name of the SNS topic"
}

variable "subscription_protocol" {
  description = "The protocol for the SNS subscription (e.g., email, lambda, sqs)"
}

variable "subscription_endpoint" {
  description = "The endpoint for the SNS subscription (e.g., email address, Lambda ARN, SQS ARN)"
}