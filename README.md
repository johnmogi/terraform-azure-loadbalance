# terraform_submit_project

in this project we deploy a load balance into 3 virtual machines.
a postgres sql server all with Terraform.

request: llazargjermeni to
##~~ requirements:
db vm postgres that runs with docker on the machine port 5432
loadbalanced into 3 machines on 8080 with the app running

<!-- Use Terraform to define all the infrastructure -->
<!-- Use Terraform variables to configure at least 5 parameters for your template -->

Configure a terraform output, so the vm password can be retrieved during automation (Linux servers must be configured with password authentication instead of SSH keys)

<!-- Create a terraform module to reuse the code that creates the virtual machines -->

Install the WeightTracker application and the Database into the VMs created by terraform (the installation can be done manually)
Ensure the application is up and running (and work automatically after reboot)

Ensure your Network Security Group (NSG) allows you to access the servers and allows communication between the web server and the database
Make sure the database cannot be accessed from the internet (it’s not publicly exposed)

q: will it be easier to scale set? (bonus c)
bonus a:
Use a Terraform backend to store the Terraform state in Azure Blob Storage
example: https://github.com/MatanTal2/terraform/blob/main/bonusA/backend.tf

bonus b:
Use the Azure PostgreSQL manged service instead of a VM (Bonus “B” from previous week)

bonus c:
Implement the bonus “C” (Elasticity) from the previous project using Terraform

modify this readme with proper documentation + updated terraform docs.

status: terraform not provisioned- continue at 19.00

notes and tasks:

if you've got nothing to do - prp for quiz...

## {seek mentors and friends on the channel for help !}

-are we sure that the machine is installed?

- added exit codes + sudo to scripts.
  Custom Script Extensions require that the [Azure Virtual Machine Guest Agent]- is this good?

* is running on the Virtual Machine?

https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension

[!!!] transform vm into a module - base requirement
{!!!} don't forget to output password for the machine

bonus:
create a flexible postgres paas instance and replace it instead of the backend machine.
# terraform-azure-loadbalance
