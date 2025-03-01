output "student_username" {
  value = module.student.student_username
}

output "student_password" {
  value     = module.student.student_password
  sensitive = true
}


output "aws_console_url" {
  value = "https://${data.aws_caller_identity.current.account_id}.signin.aws.amazon.com/console"
}
