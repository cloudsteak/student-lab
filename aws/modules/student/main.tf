resource "aws_s3_bucket" "student_bucket" {
  bucket = "${var.student_username}-lab-cloudmentor"
  tags          = var.tags
  force_destroy = true
}

# resource "aws_s3_bucket_public_access_block" "student_bucket_block" {
#   bucket = aws_s3_bucket.student_bucket.id

#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }

resource "aws_iam_user" "student" {
  name = var.student_username
  tags = var.tags
}


# resource "aws_iam_user_login_profile" "student_password" {
#   user                    = aws_iam_user.student.name
#   password_length         = 18
#   password_reset_required = false

# }


resource "null_resource" "set_iam_password" {
  depends_on = [aws_iam_user.student]

  triggers = {
    always_run = timestamp() # Ensures execution on every apply
  }

  provisioner "local-exec" {
    command = <<EOT
    aws iam create-login-profile \
      --user-name ${aws_iam_user.student.name} \
      --password "${var.student_password}" \
      --no-password-reset-required || \
    aws iam update-login-profile \
      --user-name ${aws_iam_user.student.name} \
      --password "${var.student_password}" \
      --no-password-reset-required
    EOT
  }
}


resource "aws_iam_access_key" "student" {
  user = aws_iam_user.student.name
}


resource "aws_iam_role" "student_role" {
  name = var.student_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        AWS = aws_iam_user.student.arn
      },
      Action = "sts:AssumeRole"
    }]
  })
}


resource "aws_iam_policy" "student_restrict_s3_access" {
  name        = "student-s3-access-${var.student_username}"
  description = "Grants access to the student's own S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      # ✅ Allow listing the bucket itself
      {
        Effect   = "Allow",
        Action   = ["s3:ListBucket"],
        Resource = "arn:aws:s3:::${var.student_username}-lab-cloudmentor",
        Condition = {
          "StringLike": {
            "s3:prefix": [""]
          }
        }
      },

      # ✅ Allow listmybucket
      {
        Effect   = "Allow",
        Action   = ["s3:ListAllMyBuckets"],
        Resource = "*"
      },
      

      # ✅ Allow access to objects inside the bucket
      {
        Effect   = "Allow",
        Action   = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ],
        Resource = "arn:aws:s3:::${var.student_username}-lab-cloudmentor/*"
      },

      # ❌ Deny access to any other S3 buckets
      {
        Effect   = "Deny",
        Action   = "s3:*",
        Resource = "*",
        Condition = {
          "StringNotEquals": {
            "aws:username": aws_iam_user.student.name
          }
        }
      }
    ]
  })
}


resource "aws_iam_user_policy_attachment" "student_s3_attach" {
  user       = aws_iam_user.student.name
  policy_arn = aws_iam_policy.student_restrict_s3_access.arn
}

