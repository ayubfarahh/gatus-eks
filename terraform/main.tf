module "networking" {
  source = "./modules/networking"
}

module "eks" {
  source       = "./modules/eks"
  priv_subnets = module.networking.priv_subnets
}
