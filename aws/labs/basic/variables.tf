variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "eu-north-1"

}

variable "student_username" {
  description = "The student username"
  type        = string

}

variable "student_password" {
  description = "The student password"
  type        = string
  sensitive = true

}

locals {
  tags = {
    Name        = "cloudmentor-lab"
    Environment = "training"

  }
}
