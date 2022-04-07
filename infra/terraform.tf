terraform {
  required_providers {
    azurerm = {
      version = "=2.86.0"
    }
    random = {
      version = "=3.1.0"
    }
  }
  
  backend "azurerm" {
    resource_group_name   = "wordpress_demo_tfstate_rg"
    storage_account_name  = "wordpressdemosa"
    container_name        = "wordpress-demo-tfstate-c"
    key                   = "wordpress.tfstate"
  }
}