resource "azurerm_container_registry" "acr-flask" {
  name                = "acrflaskgitactions"
  resource_group_name = azurerm_resource_group.rg.name
  location            = "France Central"
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_container_group" "aci-flask" {
  name                = "aci-terraform-dev-francecentral"
  resource_group_name = azurerm_resource_group.rg.name
  location            = "France Central"
  os_type             = "Linux"

  ip_address_type = "Private"
  subnet_ids      = [azurerm_subnet.containers.id]

  image_registry_credential {
    server   = azurerm_container_registry.acr-flask.login_server
    username = azurerm_container_registry.acr-flask.admin_username
    password = azurerm_container_registry.acr-flask.admin_password
  }

  container {
    name   = "flask-web"
    image  = "${azurerm_container_registry.acr-flask.login_server}/flask-app:${var.docker_image_tag}"
    cpu    = "1.0"
    memory = "1.0"
    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  tags = {
    Propietario = "Ivelin"
    Proyecto    = "Terraform"
    Entorno     = "Desarrollo"
    Version     = "v1"
  }
}