module "networking" {
  source = "./modules/networking"
}

module "eks" {
  source       = "./modules/eks"
  priv_subnets = module.networking.priv_subnets
  vpc_id       = module.networking.vpc_id
}

module "irsa" {
  source = "./modules/irsa"

}