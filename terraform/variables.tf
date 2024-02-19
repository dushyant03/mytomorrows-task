variable "application_deployment_account" {
  description = "name of the account to deploy to"
  type        = string
}

variable "db_password" {
  description = "DB password"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}
