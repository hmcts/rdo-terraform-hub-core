#!/bin/bash
set -ex

 << --MULTILINE-COMMENT--
  Description: Pre-Populate KeyVault Data per environment / subscription
  Running this script, upon the the subscription creation will pre-populate your keyvault with the required Secrets

  Under Hub and DMZ you will need to fill some vaules before running this script

 
  #Note: 
  When running command you need to add the Environment Example
  Example: ./keyvault.sh sbox

--MULTILINE-COMMENT-- >>
LOCATION="uksouth"
ENVIRONMENT="${1}"

COMMON_TAGS=(
  "managedBy=Refrom DevOps" 
  "solutionOwner=HMCTS" 
  "activityName=HUB" 
  "dataClassification=internal" 
)

HMCTS_HUB_INFRA="hmcts-infra-hub-${ENVIRONMENT}"
HMCTS_DMZ_INFRA="hmcts-infra-dmz-${ENVIRONMENT}"
HMCTS_HUB="hmcts-hub-${ENVIRONMENT}"
HMCTS_DMZ="hmcts-dmz-${ENVIRONMENT}"


########################################   HUB Build Out  ########################################

az keyvault secret set --vault-name ${HMCTS_HUB_INFRA} --name 'backend-storage-account-name' --value ${HMCTS_HUB_INFRA//-/}
az keyvault secret set --vault-name ${HMCTS_HUB_INFRA} --name 'backend-storage-container-name' --value 'tfstate'
az keyvault secret set --vault-name ${HMCTS_HUB_INFRA} --name 'environment' --value ${1}
az keyvault secret set --vault-name ${HMCTS_HUB_INFRA} --name 'firewall-name-prefix' --value 'core-dmz-fw'
az keyvault secret set --vault-name ${HMCTS_HUB_INFRA} --name 'firewall-subnet-management' --value 'hub-mgmt'
az keyvault secret set --vault-name ${HMCTS_HUB_INFRA} --name 'firewall-subnet-transit' --value 'hub-transit-private'
az keyvault secret set --vault-name ${HMCTS_HUB_INFRA} --name 'firewall-subnet-transit-private' --value 'hub-transit-private'
az keyvault secret set --vault-name ${HMCTS_HUB_INFRA} --name 'firewall-subnet-transit-public' --value 'hub-transit-public'
az keyvault secret set --vault-name ${HMCTS_HUB_INFRA} --name 'firewall-username' --value 'localadmin'
az keyvault secret set --vault-name ${HMCTS_HUB_INFRA} --name 'location' --value ${LOCATION}
az keyvault secret set --vault-name ${HMCTS_HUB_INFRA} --name 'rg-name' --value ${HMCTS_HUB}
az keyvault secret set --vault-name ${HMCTS_HUB_INFRA} --name 'vnet-name' --value ${HMCTS_HUB}

# NEEDS VALUES for HUB KeyVaults
az keyvault secret set --vault-name ${HMCTS_HUB_INFRA} --name 'backend-access-key' --value '######################################################################'
az keyvault secret set --vault-name ${HMCTS_HUB_INFRA} --name 'dmz-sp-app-id' --value '######################################################################'
az keyvault secret set --vault-name ${HMCTS_HUB_INFRA} --name 'dmz-sp-client-secret' --value '######################################################################'
az keyvault secret set --vault-name ${HMCTS_HUB_INFRA} --name 'dmz-sp-tenant-id' --value '######################################################################'
az keyvault secret set --vault-name ${HMCTS_HUB_INFRA} --name 'firewall-password' --value '######################################################################'
az keyvault secret set --vault-name ${HMCTS_HUB_INFRA} --name 'subnet-mgmt-prefix' --value '######################################################################'
az keyvault secret set --vault-name ${HMCTS_HUB_INFRA} --name 'subnet-private-prefix' --value '######################################################################'
az keyvault secret set --vault-name ${HMCTS_HUB_INFRA} --name 'subnet-public-prefix' --value '######################################################################'
az keyvault secret set --vault-name ${HMCTS_HUB_INFRA} --name 'subscription-id' --value '######################################################################'
az keyvault secret set --vault-name ${HMCTS_HUB_INFRA} --name 'vnet-cidr' --value '######################################################################'
az keyvault secret set --vault-name ${HMCTS_HUB_INFRA} --name 'key' --value '######################################################################'


########################################   DMZ Build Out  ########################################


az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'admin-username' --value 'sftpadmin'
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'as3-username' --value 'as3_admin'
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'backend-storage-account-name' --value ${HMCTS_DMZ_INFRA//-/}
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'backend-storage-container-name' --value 'tfstate'
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'environment' --value ${1}
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'firewall-name-prefix' --value 'core-dmz-fw'
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'firewall-username' --value 'localadmin'
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'loadbalancer-subnet-management' --value 'dmz-mgmt'
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'loadbalancer-subnet-vip' --value 'dmz-loadbalancer'
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'loadbalancer-username' --value 'local-admin'
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'location' --value ${LOCATION}
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'proxy-admin-username' --value 'local-root'
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'proxy-subnet-vip' --value 'dmz-proxy'
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'proxy-vm-name' --value 'proxy-${ENVIRONMENT}'
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'rg-name' --value ${HMCTS_DMZ}
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'smtp-email-address' --value 'eftsftp@gmail.com'
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'vnet-name' --value ${HMCTS_DMZ}

# NEEDS VALUES for DMZ KeyVault
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'admin-password' --value '######################################################################'
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'as3-password' --value '######################################################################'
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'azcontainer-password' --value '######################################################################'
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'backend-access-key' --value '######################################################################'
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'dmz-sp-app-id' --value '######################################################################'
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'dmz-sp-client-secret' --value '######################################################################'
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'dmz-sp-tenant-id' --value '######################################################################'
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'firewall-password' --value '######################################################################'
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'hub-storage-account-name' --value '######################################################################'
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'key' --value '######################################################################'
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'loadbalancer-password' --value '######################################################################'
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'smtp-password' --value '######################################################################'
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'ssh-public-key' --value '######################################################################'
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'subnet-dmz-loadbalancer-prefix' --value '######################################################################'
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'subnet-dmz-palo-private-prefix' --value '######################################################################'
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'subnet-dmz-palo-public-prefix' --value '######################################################################'
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'subnet-dmz-proxy-prefix' --value '######################################################################'
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'subnet-mgmt-prefix' --value '######################################################################'
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'subscription-id' --value '######################################################################'
az keyvault secret set --vault-name ${HMCTS_DMZ_INFRA} --name 'vnet-cidr' --value '######################################################################'
