# url-shortner-duplicate
Just Duplicate repo 


## Infrastructur as Code

### Download Azure CLI
```bash
winget install --exact --id Microsoft.AzureCLI
```

### Login into Azure
```bash
az login
```

### Create Resource Group

```bash
az group create --name urlshortner --location southeastasia
```

### To Run Main.bicep from azure cli

```bash

az deployment group  what-if --resource-group urlshortner --template-file infrastructure/main.bicep


az deployment group  create --resource-group urlshortner --template-file infrastructure/main.bicep
```

### To Create Service user for Github Actions in Azure

```bash
az ad sp create-for-rbac --name "Github-Actions-SP" --role Contributor --scopes /subscriptions/67a63877-9ecd-4d2a-b2c2-7cf4047395bb  --sdk-auth


```
### Apply Custom Contribute Role 

```bash
az ad sp create-for-rbac --name "GitHub-Actions-SP" --role infra_deploy_duplicate  --scopes /subscriptions/67a63877-9ecd-4d2a-b2c2-7cf4047395bb --sdk-auth

```