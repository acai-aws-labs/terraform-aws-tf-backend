#---------------------------------------------------------------------------------------------------
# General
#---------------------------------------------------------------------------------------------------
variable "tags" {
  description = "A mapping of tags to assign to resources."
  default = {
    Terraform = "true"
  }
}

#---------------------------------------------------------------------------------------------------
# IAM Policy for Executing Terraform with Remote States
#---------------------------------------------------------------------------------------------------
variable "terraform_iam_policy_create" {
  description = "Specifies whether to terraform IAM policy is created."
  default     = true
}

variable "terraform_iam_policy_name_prefix" {
  description = "Creates a unique name beginning with the specified prefix."
  default     = "terraform"
}

#---------------------------------------------------------------------------------------------------
# S3 Buckets
#---------------------------------------------------------------------------------------------------
variable "state_bucket_name" {
  description = "Creates a unique state bucket name beginning with the specified prefix."
  default     = "tf-remote-state"
}

variable "iam_role_arn" {
  description = "Use IAM role of specified ARN for s3 replication instead of creating it."
  default     = null
}

variable "s3_bucket_force_destroy" {
  description = "A boolean that indicates all objects should be deleted from S3 buckets so that the buckets can be destroyed without error. These objects are not recoverable."
  default     = false
}

#---------------------------------------------------------------------------------------------------
# DynamoDB Table for State Locking
#---------------------------------------------------------------------------------------------------
variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table to use for state locking."
  default     = "tf-remote-state-lock"
}

variable "dynamodb_table_billing_mode" {
  description = "Controls how you are charged for read and write throughput and how you manage capacity."
  default     = "PAY_PER_REQUEST"
}
