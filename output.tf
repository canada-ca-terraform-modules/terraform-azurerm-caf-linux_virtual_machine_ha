output "vm_ha_1" {
  description = "The vm_1 module object"
  value       = module.linux_VM_HA1
}

output "vm_ha_2" {
  description = "The vm_2 module object"
  value       = module.linux_VM_HA2
}

output "availability_set" {
  description = "The availability_set object"
  value       = azurerm_availability_set.availability_set
}