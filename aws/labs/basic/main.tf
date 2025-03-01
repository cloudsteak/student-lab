provider "aws" {
  region  = var.aws_region
  profile = var.credential_profile
}

data "aws_caller_identity" "current" {}

module "student" {
  source             = "../../modules/student"
  student_username   = var.student_username
  credential_profile = var.credential_profile
  aws_region         = var.aws_region
  tags               = local.tags
  student_role_name  = "student-role-${var.student_username}"
}



