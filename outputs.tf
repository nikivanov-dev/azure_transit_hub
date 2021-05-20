
output "debhub_public_ip_address" {
  description = "The Public ip address allocated for the hub vm."
  value       = azurerm_linux_virtual_machine.debhub.public_ip_address
}

