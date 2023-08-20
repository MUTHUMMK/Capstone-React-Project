terraform {
  backend "s3" {
    bucket         = "terraform-statetf-file"
    key            = "statetf"                 # Change this to a unique name for each configuration
    region         = "ap-south-1"           # Change to your desired AWS region
    encrypt        = true                   # Set to true if you want to encrypt the state file
    dynamodb_table = "DynamoDB-lock"          # Optional: Use DynamoDB for locking
  }
}