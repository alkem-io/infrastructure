# Secrets and secret stores
There are two main types of secretes in this project concurring infrastructure. The first is the secrets that are stored in Githubs secret store. These secrets are used in the github actions to push/pull containers from the azure container registry, deploy containers to kubernetes, and to run deployment manifests on kubernetes. These secrets are added when a new container registry or kuberneties cluster is created as they require current RBAC to access their needed resources. 

For connecting github acctions to the acr a brief set of steps are proved. For more details please see the [ms docs](https://docs.microsoft.com/en-us/azure/container-instances/container-instances-github-action):
- Create service principal for Azure authentication
  - `groupId=$(az group show \
     --name <resource-group-name> \
     --query id --output tsv)`
  - `az ad sp create-for-rbac \
     --scope $groupId \
     --role Contributor \
     --sdk-auth`
  - Save the output for later
- Update service principal for registry authentication
  - `registryId=$(az acr show \
     --name <registry-name> \
     --query id --output tsv)`
  - `az role assignment create \
     --assignee <ClientId> \
     --scope $registryId \
     --role AcrPush`
- Save credentials to GitHub repo
  - AZURE_CREDENTIALS: The entire JSON output from the service principal creation step
  - REGISTRY_LOGIN_SERVER: The login server name of your registry (all lowercase). Example: myregistry.azurecr.io
  - REGISTRY_USERNAME: The clientId from the JSON output from the service principal creation
  - REGISTRY_PASSWORD: The clientSecret from the JSON output from the service principal creation
  - RESOURCE_GROUP: The name of the resource group you used to scope the service principal

A brief overview to add rbac from acr to aks, see [ms docs here](https://docs.microsoft.com/en-us/azure/aks/cluster-container-registry-integration) for more info:
- `az aks update -n myAKSCluster -g myResourceGroup --attach-acr <acr-name>`

The second set of secretes for the infrastructure is in the kubernetes deployment. These are used for inter-service communication / authentication. These have been described above in the deployment steps.
