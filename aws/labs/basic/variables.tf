variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "eu-north-1"

}

variable "credential_profile" {
  description = "The AWS CLI profile to use for the backend"
  type        = string
  default     = "cloudmentor-lab-terraform"

}

variable "student_username" {
  description = "The student username"
  type        = string

}


locals {
  tags = {
    Name        = "cloudmentor-lab"
    Environment = "training"

  }
}
