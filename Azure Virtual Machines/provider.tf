terraform {
 #required_version = "1.9.3"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.21.1"
    }

    null = {
      source = "hashicorp/null"
      version = "3.2.3"
    }
    
  }
}

# provider "azurerm" {
#     subscription_id = ""
#   features {
    
#   }
# }

provider "azurerm" {
  # Configuration options
  alias = "dev_env"
  subscription_id = "01202567-6e50-4f04-b07a-77bb79f043f9"

  features {

# prevent_deletion_if_contains_resources:
# If set to true, Terraform will prevent the deletion of a resource group if it contains resources.
# Default: false.
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }

}
