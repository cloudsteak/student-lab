variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "eu-north-1"

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
