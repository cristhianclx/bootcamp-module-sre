terraform {
  backend "s3" {
    bucket                  = "infrastructure.demo.pe"
    key                     = "tf/main/sre.tfstate"
    encrypt                 = "true"
    shared_credentials_file = ".aws/credentials"
    profile                 = "infrastructure"
    region                  = "sa-east-1"
  }
}


