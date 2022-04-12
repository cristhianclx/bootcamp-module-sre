terraform {
  backend "s3" {
    bucket  = "infrastructure.demo.pe"
    key     = "tf/main/sre.tfstate"
    encrypt = "true"
    region  = "sa-east-1"
  }
}
