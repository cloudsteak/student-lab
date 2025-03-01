# Student labs for Azure and AWS

aws/
├── modules/
│   ├── backend/               # Terraform backend module
│   │   ├── main.tf            # Defines the S3 backend
│   │   ├── variables.tf       # Input variables (bucket, student ID, profile)
│   │   └── outputs.tf         # Outputs S3 details
│
├── labs/
│   ├── basic/                 # Example AWS lab
│   │   ├── main.tf            # Defines lab resources (e.g., EC2, S3)
│   │   ├── variables.tf       # Lab-specific variables
│   │   ├── outputs.tf         # Outputs lab results
│   │   └── backend.tf         # Calls backend module
│
└── README.md                  # Documentation
