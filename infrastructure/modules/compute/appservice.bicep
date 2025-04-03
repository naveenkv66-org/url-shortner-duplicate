
param appServicePlanName string
param location string
param appName string
param keyVaultName string
resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
  name: appServicePlanName
  location: location
  kind: 'linux'
  tags: {
    displayName: 'App Service Plan'
  }
  sku: {
    name: 'B1'
    tier: 'Basic'
    capacity: 1
  }
  properties: {
    reserved: true
 
  }
}

resource appService 'Microsoft.Web/sites@2024-04-01' = {
    name: appName
    location: location
    kind: 'linux'
    tags: {
      displayName: 'App Service'
    }
    properties: {
      serverFarmId: appServicePlan.id
      reserved: true
      httpsOnly: true
      siteConfig: {
        linuxFxVersion: 'DOTNETCORE|8.0'
        appSettings: [
          {
            name: 'KeyVaultName'
            value: keyVaultName
          }
         
        ]
      }

    }
    identity: {
      type: 'SystemAssigned'
    }
    
}

resource appConfig 'Microsoft.Web/sites/config@2024-04-01' = {
  name: 'web'
  parent: appService
  properties: {
    scmType: 'GitHub'
  }
}


output appServicePlanName string = appServicePlan.name
output appServicePrincipalId string = appService.identity.principalId
