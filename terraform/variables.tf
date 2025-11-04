variable "aws_region" {
  description = "Region for AWS resources"
  type        = string
  default     = "eu-central-1" # Frankfurt
}

variable "project_name" {
  description = "Project name prefix for resources"
  type        = string
  default     = "gamevault"
}
