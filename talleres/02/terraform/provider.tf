provider "aws" {
  shared_credentials_files = ["./.aws/credentials"]
  profile                  = "infrastructure"
  region                   = "us-east-1"
}
