# terraform_submit_project

This week's project is unfortunately a [ fail in deploy... ] / [ success with self learn ] (:

- manage to create the entire network with terraform
- looking into automation using shell, i understand this part is less important.

* on the submitted topology I switched the backend server to the postgresql managed
  this is a last minute change - some naming of resources might look and feel as the backend I'm using for sys admin overtook the bacend.

in this project we deploy a load balance into 3 virtual machines.
a postgres sql server all with Terraform.

##~~ requirements:
db vm postgres that runs with docker on the machine port 5432
loadbalanced into 3 machines on 8080 with the app running

<!-- Use Terraform to define all the infrastructure -->
<!-- Use Terraform variables to configure at least 5 parameters for your template -->
<!--
Configure a terraform output, so the vm password can be retrieved during automation (Linux servers must be configured with password authentication instead of SSH keys) -->
<!-- Create a terraform module to reuse the code that creates the virtual machines -->

Install the WeightTracker application and the Database into the VMs created by terraform (the installation can be done manually)
Ensure the application is up and running (and work automatically after reboot)

Ensure your Network Security Group (NSG) allows you to access the servers and allows communication between the web server and the database
Make sure the database cannot be accessed from the internet (it’s not publicly exposed)

bonus a:
Use a Terraform backend to store the Terraform state in Azure Blob Storage
https://portal.azure.com/#view/Microsoft_Azure_Storage/ContainerMenuBlade/~/overview/storageAccountId/%2Fsubscriptions%2Ff0de5eae-71b0-412c-9a68-49f436648228%2FresourceGroups%2Fcloud-shell-storage-westeurope%2Fproviders%2FMicrosoft.Storage%2FstorageAccounts%2Fcsb1003200202a74581/path/datestorage/etag/%220x8DA4EFF1E4FFFE2%22/defaultEncryptionScope/%24account-encryption-key/denyEncryptionScopeOverride~/false/defaultId//publicAccessVal/None

bonus b:
Use the Azure PostgreSQL manged service instead of a VM (Bonus “B” from previous week)

bonus c:
Implement the bonus “C” (Elasticity) from the previous project using Terraform

used the following for automation:
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension

bonus:
create a flexible postgres paas instance and replace it instead of the backend machine.

# terraform-azure-loadbalance docs:

## Requirements

| Name                                                                     | Version  |
| ------------------------------------------------------------------------ | -------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >=0.15.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm)       | =2.56.0  |

## Providers

| Name                                                         | Version |
| ------------------------------------------------------------ | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | 2.56.0  |
| <a name="provider_random"></a> [random](#provider_random)    | 3.3.1   |

## Modules

No modules.

## Resources

| Name                                                                                                                                                                                               | Type     |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [azurerm_availability_set.avset](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/availability_set)                                                                 | resource |
| [azurerm_lb.azurerm_lb](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/lb)                                                                                        | resource |
| [azurerm_lb_backend_address_pool.backend_pool](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/lb_backend_address_pool)                                            | resource |
| [azurerm_lb_rule.azurerm_lb_rule](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/lb_rule)                                                                         | resource |
| [azurerm_linux_virtual_machine.frontendServer](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/linux_virtual_machine)                                              | resource |
| [azurerm_linux_virtual_machine.postgresMachine](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/linux_virtual_machine)                                             | resource |
| [azurerm_network_interface.network_interface_app](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/network_interface)                                               | resource |
| [azurerm_network_interface.network_interface_db](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/network_interface)                                                | resource |
| [azurerm_network_interface_security_group_association.be_nsg_assoc](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/network_interface_security_group_association)  | resource |
| [azurerm_network_interface_security_group_association.fe_nsg_assoc0](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_interface_security_group_association.fe_nsg_assoc1](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_interface_security_group_association.fe_nsg_assoc2](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_security_group.backend_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/network_security_group)                                            | resource |
| [azurerm_network_security_group.public_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/network_security_group)                                                | resource |
| [azurerm_public_ip.frontend_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/public_ip)                                                                  | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/resource_group)                                                                        | resource |
| [azurerm_subnet.backend_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/subnet)                                                                            | resource |
| [azurerm_subnet.frontend_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/subnet)                                                                           | resource |
| [azurerm_virtual_network.weight_app_network](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/virtual_network)                                                      | resource |
| [random_pet.name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet)                                                                                              | resource |

## Inputs

| Name                                                                           | Description                     | Type     | Default              | Required |
| ------------------------------------------------------------------------------ | ------------------------------- | -------- | -------------------- | :------: |
| <a name="input_admin_password"></a> [admin_password](#input_admin_password)    | frontend admin password         | `string` | `"P@$$w0rd1234!"`    |    no    |
| <a name="input_admin_username"></a> [admin_username](#input_admin_username)    | frontend admin user name        | `string` | `"adminuser"`        |    no    |
| <a name="input_location"></a> [location](#input_location)                      | Location of the resource group. | `string` | `"eastus"`           |    no    |
| <a name="input_machines_number"></a> [machines_number](#input_machines_number) | n/a                             | `number` | `3`                  |    no    |
| <a name="input_prefix"></a> [prefix](#input_prefix)                            | weight app prefix               | `string` | `"weight_app"`       |    no    |
| <a name="input_rg_main"></a> [rg_main](#input_rg_main)                         | n/a                             | `string` | `"weight_app_group"` |    no    |

## Outputs

| Name                                                        | Description                                  |
| ----------------------------------------------------------- | -------------------------------------------- |
| <a name="output_password"></a> [password](#output_password) | output "username" { value = admin_username } |
