var location = resourceGroup().location
var  uniqueId = uniqueString(resourceGroup().id)

var appServicePlanName = 'plan-api-${uniqueId}'
var appServiceName = 'api-${uniqueId}'

module apiService 'modules/compute/appservice.bicep' = {
  name: 'appServicePlanDeployment'
  params: {
    appServicePlanName: appServicePlanName
    location: location
    appName: appServiceName
    
  }
}

