Pre-Provisioning Steps

Request Subscription is setup
  Add name to your user account in Ansible-Management and run job

Once Access to Subscription
  Run bootstrap/bootstrap.sh (ready scritp first - very basic)
  Run bootstrap/keyvault.sh ( this will create the key not add the value - eady scritp first - very basic)

Once Core-Infra Services have been built, 

Reguest - Service Principal create in Azure DevOps
Add User to Keyvault Access Policy

You will need to accept terms and conditions in each subscription
Palo 
F5 Best 25Mbs

az login
az account list -o table
az account set -s (Subscription)
az vm image list --all --publisher paloaltonetworks --offer vmseries1 --sku bundle2 --query '[0].urn'
az vm image accept-terms --urn paloaltonetworks:vmseries1:bundle2:7.1.1

Note:
Until Ansible Azure Key Vault Retrieve is fixed we have to manually 
create Storage container called certs
upload the * platform wildcard onto the dmz storage account