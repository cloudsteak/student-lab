# terraform {
#   backend "s3" {
#     bucket       = "cloudmentor-lab-terraform-state-bucket"
#     key          = "labs/basic/terraform.tfstate"
#     region       = "eu-north-1"
#     encrypt      = true
#     use_lockfile = true
#     profile      = "cloudmentor-lab-terraform"
#   }
# }


terraform {
  backend "s3" {}
}
