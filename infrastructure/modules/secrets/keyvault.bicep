param location string = resourceGroup().location
param keyVaultName string


resource keyVault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: keyVaultName
  location: location
 
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    enableRbacAuthorization: true
    tenantId: subscription().tenantId

   
  }
}
output keyVaultId string = keyVault.id
output keyVaultName string = keyVault.name
