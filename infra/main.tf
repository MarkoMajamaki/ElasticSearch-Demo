provider "azurerm" {
  features {}
}

module "rg" {
  source = "./../../modules/rg"
  name = var.rg_name
  location = var.location
}

module "acr" {
  source = "./../../modules/acr"
  name = var.acr_name
  rg_name = module.rg.name
  location = var.location
  sku = "Standard"

  depends_on = [
    module.rg
  ]
}

module "aks" {
  source = "./../../modules/aks"
  acr_id = module.acr.acr_id
  cluster_name = var.cluster_name
  kubernetes_version = var.kubernetes_version
  location = var.location
  rg_name = module.rg.name
  node_count = var.node_count
  vm = var.vm
}