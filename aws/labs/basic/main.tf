provider "aws" {
  region = var.aws_region
}

data "aws_caller_identity" "current" {}

module "USER" {
  source            = "../../modules/user"
  student_username  = var.student_username
  aws_region        = var.aws_region
  tags              = local.tags
  student_role_name = "student-role-${var.student_username}"
}



