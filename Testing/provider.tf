terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.0.0"

    }
  }
  backend "azurerm" {
    resource_group_name  = "pipline_rg"
    storage_account_name = "storagepipeline6632"
    container_name       = "pipelinetfstate"
    key                  = "pipeline.tfstate"

  }
}
provider "azurerm" {
  features {}

}