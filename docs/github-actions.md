# To Update Github Actions
- Create an Azure role assignment for the scope of your Azure subscription and resource group.
```
az ad sp create-for-rbac --sdk-auth --role contributor --scopes /subscriptions/{subscription id}/resourceGroups/azure-k8s-dev
```
- Go to the organizational secrets and update the secret `AZURE_CRED_K8S` with the output of the previous command