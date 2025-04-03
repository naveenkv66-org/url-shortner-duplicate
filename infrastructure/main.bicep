var location = resourceGroup().location
var  uniqueId = uniqueString(resourceGroup().id)

var appServicePlanName = 'plan-api-${uniqueId}'
var appServiceName = 'api-${uniqueId}'

module keyVault 'modules/secrets/keyvault.bicep' = {
  name: 'keyVaultDeployment'
  params: {
    location: location
    keyVaultName: 'kv-${uniqueId}'
  }
}

module apiService 'modules/compute/appservice.bicep' = {
  name: 'appServicePlanDeployment'
  params: {
    appServicePlanName: appServicePlanName
    location: location
    appName: appServiceName
    keyVaultName: keyVault.outputs.keyVaultName
    
  }
  
}

module keyVaultRoleAssignment 'modules/secrets/key-vault-role-assignment.bicep' = {
  name: 'keyVaultRoleAssignmentDeployment'
  params: {
    keyVaultName: keyVault.outputs.keyVaultName
    principleIds: [
      apiService.outputs.appServicePrincipalId
    ]
  }
 
}


