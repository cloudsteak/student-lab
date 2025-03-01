
output "student_username" {
  value = aws_iam_user.student.name
}

output "student_password" {
  value     = aws_iam_user_login_profile.student_password.password
  sensitive = true
}
