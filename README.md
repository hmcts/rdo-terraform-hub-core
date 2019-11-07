# Pre-Provisioning Steps

## Request Subscription is setup
  Under your name in Ansible-Management Repo, create a PR add the newly created Subscription Group
    ex - dcd_group_sub_contrib_XXXXXX_V2

## Access to Subscription
  The Subscription will need to be bootstrapped so Resource Groups / Storage Account and Keyvaults for that subscription are created
    # Note: This will change in the future
```bash
bootstrap/bootstrap.sh # ( ready script first before running )
bootstrap/keyvault.sh  # ( ready script first before running )
```

Once built, 

Reguest - Service Principal create in Azure DevOps
Add User to Keyvault Access Policy

You will need to accept terms and conditions in each subscription for the following Virtual Machines
Palo 
F5 Best 25Mbs

```bash
az login
az account list -o table
az account set -s (Subscription)
az vm image list --all --publisher paloaltonetworks --offer vmseries1 --sku bundle2 --query '[0].urn'
az vm image accept-terms --urn paloaltonetworks:vmseries1:bundle2:7.1.1
```

Note:
Until Ansible Azure Key Vault Retrieve is fixed we have to manually 
create Storage container called certs
upload the * platform wildcard onto the dmz storage account

# Overview

This is the first module that is run, as part of the HUB-DMZ pipeline, this builds the foundations that is required for the HUB section to exists, it will
ensure the Resource Groups exist and then create the VNETS / SUBNETS and Network Security Groups.

Documentation: https://tools.hmcts.net/confluence/display/RD/HUB-DMZ+Overview