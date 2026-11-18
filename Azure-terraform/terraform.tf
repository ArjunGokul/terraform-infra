terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
  cloud {

    organization = "arjun-terraform-workspace"

    workspaces {
      name = "terraform-azure-project"
    }
  }
  #backend "azurerm" {
  #  resource_group_name = "central-india-rg"
  #  storage_account_name = "terraformremotestate"
  #  container_name       = "tfstate"  
  #  key                  = "terraform.tfstate"
  #}
}
