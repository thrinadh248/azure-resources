data "azurerm_client_config" "current" {}

module "keyvault" {
  
  source                    = "../../../../../../../services/keyvault/endpoint/base/v1"

  context                  = var.context
  
  service_settingd = {
    name                      = "${var.context.application_name}-${var.context.environment_name}-${var.context.location_suffix}"
    loganalytics_workspace_id = var.workspace_id
  }

}


module "terraform_admin" {
  
  source                = "../../../../../../../services/keyvault/accesspolicy/templates/machine-admin/v1"

  keyvault_id           = module.keyvault.id
  application_id        = data.azurerm_client_config.current.client_id

}