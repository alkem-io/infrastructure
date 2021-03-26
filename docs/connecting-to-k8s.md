# To Connect to K8s
## Azure
- A recommendation is the use the `lens` Kube IDE for connection: `https://github.com/lensapp/lens`
- Download and log into azure cli `az --login`
- Next run `az aks get-credentials --resource-group azure-k8s-dev --name k8s-dev` to get your kube creds

## AWS
- Follow the prerequisites on [the Hashicorp's EKS terraform tutorial](https://learn.hashicorp.com/tutorials/terraform/eks)


