terraform {
  backend "s3" {
    bucket = "terra-bucket-33"
    key    = "tfstate-file"
    region = "eu-west-2"

  }
}