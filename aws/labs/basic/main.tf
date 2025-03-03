provider "aws" {
  region = var.aws_region
}

data "aws_caller_identity" "current" {}

module "student" {
  source            = "../../modules/student"
  student_username  = var.student_username
  student_password  = var.student_password
  aws_region        = var.aws_region
  tags              = local.tags
  student_role_name = "student-role-${var.student_username}"
}



