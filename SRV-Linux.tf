module "linux_VM_HA1" {
  source = "github.com/canada-ca-terraform-modules/terraform-azurerm-caf-linux_virtual_machine?ref=v1.1.11"

  env                                     = var.env
  serverType                              = var.serverType
  userDefinedString                       = var.userDefinedString
  postfix                                 = "01"
  resource_group                          = var.resource_group
  subnet                                  = var.subnet
  nic_ip_configuration                    = var.nic_ip_configuration_1
  public_ip                               = var.public_ip
  priority                                = var.priority
  license_type                            = var.license_type
  admin_username                          = var.admin_username
  admin_password                          = var.admin_password
  vm_size                                 = var.vm_size
  storage_image_reference                 = var.storage_image_reference
  storage_os_disk                         = var.storage_os_disk
  os_managed_disk_type                    = var.os_managed_disk_type
  plan                                    = var.plan
  availability_set_id                     = azurerm_availability_set.availability_set.id
  custom_data                             = var.custom_data
  ultra_ssd_enabled                       = var.ultra_ssd_enabled
  zone                                    = var.zone
  data_disks                              = var.data_disks
  encryptDisks                            = var.encryptDisks
  dependancyAgent                         = var.dependancyAgent
  shutdownConfig                          = var.shutdownConfig
  tags                                    = var.tags
}

module "linux_VM_HA2" {
  source = "github.com/canada-ca-terraform-modules/terraform-azurerm-caf-linux_virtual_machine?ref=v1.1.11"

  env                                     = var.env
  serverType                              = var.serverType
  userDefinedString                       = var.userDefinedString
  postfix                                 = "02"
  resource_group                          = var.resource_group
  subnet                                  = var.subnet
  nic_ip_configuration                    = var.nic_ip_configuration_2
  public_ip                               = var.public_ip
  priority                                = var.priority
  license_type                            = var.license_type
  admin_username                          = var.admin_username
  admin_password                          = var.admin_password
  vm_size                                 = var.vm_size
  storage_image_reference                 = var.storage_image_reference
  storage_os_disk                         = var.storage_os_disk
  os_managed_disk_type                    = var.os_managed_disk_type
  plan                                    = var.plan
  availability_set_id                     = azurerm_availability_set.availability_set.id
  custom_data                             = var.custom_data
  ultra_ssd_enabled                       = var.ultra_ssd_enabled
  zone                                    = var.zone
  data_disks                              = var.data_disks
  encryptDisks                            = var.encryptDisks
  dependancyAgent                         = var.dependancyAgent
  shutdownConfig                          = var.shutdownConfig
  tags                                    = var.tags
}

resource "azurerm_network_interface_backend_address_pool_association" "LB_linux_VM_HA1" {
  count = var.lb != null ? 1 : 0

  network_interface_id    = module.linux_VM_HA1.nic.id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.loadbalancer-lbbp[0].id
}

resource "azurerm_network_interface_backend_address_pool_association" "LB_linux_VM_HA2" {
  count = var.lb != null ? 1 : 0

  network_interface_id    = module.linux_VM_HA2.nic.id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.loadbalancer-lbbp[0].id
}