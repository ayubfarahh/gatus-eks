terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.12.0"
    }

    kubectl = {
      source = "alekc/kubectl"
    }

  }
}

provider "kubectl" {

}
provider "helm" {
  kubernetes = {

  }
}
provider "kubernetes" {

}
