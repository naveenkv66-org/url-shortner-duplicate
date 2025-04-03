param keyVaultName string

var roleDefinitionId = '4633458b-17de-408a-b874-0445c86b69e6' // Key Vault Secrets User role definition ID
param principleIds array = []
resource keyVault 'Microsoft.KeyVault/vaults@2023-02-01' existing = {
  name: keyVaultName
}
resource keyvaultRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = [for principleId in principleIds: {
  name: guid(keyVault.id, principleId, roleDefinitionId)
  properties: {
    principalId: principleId
    roleDefinitionId: roleDefinitionId
    scope: keyVault
  }
}]
