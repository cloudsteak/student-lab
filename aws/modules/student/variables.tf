variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  
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


variable "tags" {
  description = "The tags to apply to resources"
  type        = map(string)
}


variable "student_role_name" {
  description = "IAM role assigned to the student"
  type        = string
}
