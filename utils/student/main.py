import subprocess
import os
import secrets
import string
import randomname  # Generates a readable random name

# Set Terraform working directory
TERRAFORM_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), "../../aws/labs/basic/"))

# Run terraform apply command
def run_terraform_apply(student_username):
    terraform_command = [
        "terraform", "apply", "-auto-approve",
        f"-var=student_username={student_username}"
    ]

    # Change directory to Terraform workspace
    os.chdir(TERRAFORM_DIR)

    # Run Terraform apply
    try:
        subprocess.run(terraform_command, check=True)
        print(f"\n✅ Terraform apply completed successfully for {student_id}")
        subprocess.run(["terraform", "output", "student_password"], check=True)
        subprocess.run(["terraform", "output", "-raw", "student_password"], check=True)
        subprocess.run(["terraform", "output", "aws_console_url"], check=True)
    except subprocess.CalledProcessError as e:
        print("\n❌ Terraform apply failed!")
        print(e)
    

# Generate a unique student ID (max 18 characters)
def generate_student_id():
    return randomname.get_name().replace(" ", "-").replace("\"","")[:18]  # Replace spaces with "-" and limit to 18 chars

# Generate username
student_id = generate_student_id()

# Terraform init command with backend config
terraform_command = [
    "terraform", "init", "-reconfigure",
    f"-backend-config=bucket=cloudmentor-lab-terraform-state-bucket",
    f"-backend-config=key=labs/{student_id}/terraform.tfstate",
    f"-backend-config=region=eu-north-1",
    f"-backend-config=encrypt=true",
    f"-backend-config=use_lockfile=true",
    f"-backend-config=profile=cloudmentor-lab-terraform"
]

# Change directory to Terraform workspace
os.chdir(TERRAFORM_DIR)

# Run Terraform init
try:
    subprocess.run(terraform_command, check=True)
    print(f"\n✅ Terraform initialized successfully for 'student-{student_id}'")
    print(f"👤 Username: student-{student_id}")
    print(f"🚀 Apply Terraform configuration for student-{student_id}...")
    run_terraform_apply(f"student-{student_id}")
    print(f"🔑 Run this command to get password: 'terraform output student_password'")
    print(f"💣 Run this command to destroy the environment: terraform destroy -auto-approve -var='student_username=student-{student_id}'")
except subprocess.CalledProcessError as e:
    print("\n❌ Terraform initialization failed!")
    print(e)
