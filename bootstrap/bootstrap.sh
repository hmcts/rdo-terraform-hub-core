 #!/bin/bash
 set -ex

 << --MULTILINE-COMMENT--
  Description: Bootstrap Subscription 
    In Each environment, there will be 4 resource groups
      These 2 Resource Groups, will have a Key Vault / Storage Account for Terraform Remote State
          hmcts-infra-hub-${environment}
          hmcts-infra-dmz-${environment}
    # Note: This will move into a Control Subscription
    
    Within these resouce groups it will create a Keyvault for all secrets (see keyvault.sh)
    Storage Account with a tfstate container

    #Note: Due to lack of support for Azure KeyVault and Ansbile dealing with downloading SSL Certs (as of 08/11/19)
    An Additional container under the Storage Account hmcts-infra-dmz is created called "certs"
    You will need to upload the wildcard platform-hmcts.net Key and CRT


      These Resource Groups, is where our Pipelines will build Infrastructure.
          hmcts-hub-${environment}
          hmcts-dmz-${environment}

  When running command you need to add the Environment Example
  Example: ./bootstap.sh sbox

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

 # Resource Group Create
 #az login --service-principal -u ${ARM_CLIENT_ID} -p ${ARM_CLIENT_SECRET} --tenant ${ARM_TENANT_ID}
 az group create --location ${LOCATION} --name ${HMCTS_HUB_INFRA} --tags "${COMMON_TAGS[@]}"
 az group create --location ${LOCATION} --name ${HMCTS_HUB} --tags "${COMMON_TAGS[@]}"
 az group create --location ${LOCATION} --name ${HMCTS_DMZ_INFRA} --tags "${COMMON_TAGS[@]}"
 az group create --location ${LOCATION} --name ${HMCTS_DMZ} --tags "${COMMON_TAGS[@]}"

 # Storage Create
 az storage account create --name ${HMCTS_HUB_INFRA//-/} \
   --resource-group ${HMCTS_HUB_INFRA} \
   --sku Standard_LRS \
   --encryption-services blob \
   --kind StorageV2 \
   --location ${LOCATION} \
   --tags "${COMMON_TAGS[@]}" \
   --https-only true

 az storage container create  --account-name ${HMCTS_HUB_INFRA//-/}  --name tfstate

 az storage account create --name ${HMCTS_DMZ_INFRA//-/} \
   --resource-group ${HMCTS_DMZ_INFRA} \
   --sku Standard_LRS \
   --encryption-services blob \
   --kind StorageV2 \
   --location ${LOCATION} \
   --tags "${COMMON_TAGS[@]}" \
   --https-only true

 az storage container create  --account-name ${HMCTS_DMZ_INFRA//-/}  --name tfstate
 az storage container create  --account-name ${HMCTS_DMZ_INFRA//-/}  --name certs

 # KeyVault Create

 az keyvault create --name ${HMCTS_HUB_INFRA} \
   --resource-group ${HMCTS_HUB_INFRA}  \
   --location ${LOCATION} \
   --enable-purge-protection true \
   --enable-soft-delete true \
   --enabled-for-deployment true  \
   --tags "${COMMON_TAGS[@]}" \
   --enabled-for-template-deployment true

 az keyvault create --name ${HMCTS_DMZ_INFRA} \
   --resource-group ${HMCTS_DMZ_INFRA}  \
   --location ${LOCATION} \
   --enable-purge-protection true \
   --enable-soft-delete true \
   --enabled-for-deployment true  \
   --tags "${COMMON_TAGS[@]}" \
   --enabled-for-template-deployment true

 # KeyVault Access Policies

 # DevOps
 az keyvault set-policy --name ${HMCTS_HUB_INFRA} \
   --object-id 300e771f-856c-45cc-b899-40d78281e9c1 \
   --secret-permissions backup delete get list purge recover restore set \
   --certificate-permissions backup create delete deleteissuers get getissuers import list listissuers managecontacts manageissuers purge recover restore setissuers update \
   --key-permissions backup create decrypt delete encrypt get import list purge recover restore sign unwrapKey update verify wrapKey

 az keyvault set-policy --name ${HMCTS_DMZ_INFRA} \
   --object-id 300e771f-856c-45cc-b899-40d78281e9c1 \
   --secret-permissions backup delete get list purge recover restore set \
   --certificate-permissions backup create delete deleteissuers get getissuers import list listissuers managecontacts manageissuers purge recover restore setissuers update \
   --key-permissions backup create decrypt delete encrypt get import list purge recover restore sign unwrapKey update verify wrapKey


 # Platform Engineering
 az keyvault set-policy --name ${HMCTS_HUB_INFRA} \
   --object-id c36eaede-a0ae-4967-8fed-0a02960b1370 \
   --secret-permissions backup delete get list purge recover restore set \
   --certificate-permissions backup create delete deleteissuers get getissuers import list listissuers managecontacts manageissuers purge recover restore setissuers update \
   --key-permissions backup create decrypt delete encrypt get import list purge recover restore sign unwrapKey update verify wrapKey

 az keyvault set-policy --name ${HMCTS_DMZ_INFRA} \
   --object-id c36eaede-a0ae-4967-8fed-0a02960b1370 \
   --secret-permissions backup delete get list purge recover restore set \
   --certificate-permissions backup create delete deleteissuers get getissuers import list listissuers managecontacts manageissuers purge recover restore setissuers update \
   --key-permissions backup create decrypt delete encrypt get import list purge recover restore sign unwrapKey update verify wrapKey

 # Subscription Contributer User Account - need to find ObjectId for dcd_group_sub_contrib_hmcts-hub-{env}_v2

 az keyvault set-policy --name ${HMCTS_HUB_INFRA} \
   --object-id ${2} \
   --secret-permissions backup delete get list purge recover restore set \
   --certificate-permissions backup create delete deleteissuers get getissuers import list listissuers managecontacts manageissuers purge recover restore setissuers update \
   --key-permissions backup create decrypt delete encrypt get import list purge recover restore sign unwrapKey update verify wrapKey

 az keyvault set-policy --name ${HMCTS_DMZ_INFRA} \
   --object-id ${2} \
   --secret-permissions backup delete get list purge recover restore set \
   --certificate-permissions backup create delete deleteissuers get getissuers import list listissuers managecontacts manageissuers purge recover restore setissuers update \
   --key-permissions backup create decrypt delete encrypt get import list purge recover restore sign unwrapKey update verify wrapKey

