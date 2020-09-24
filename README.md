# Infrastructure
Creates deployments, managing infrastructure scripts, devops, monitoring, ...

# To Connect to K8s
- A recommendation is the use the `lens` Kube IDE for connection: `https://github.com/lensapp/lens`
- Download and log into azure cli `az --login`
- Next run `az aks get-credentials --resource-group azure-k8s-dev --name k8s-dev` to get your kube creds

# To Deploy:

- Download and log into azure cli `az --login`
- Go into `terraform-aks-k8s` directory.
- Edit the `variables.tf` file to your desired state.
- Run `terraform init` if this is your first run.
- Run `terraform plan -out out.plan`
- Look over the output
- Run `terraform apply "out.plan"`
- This will now build the full k8s deployment in azure
- Next run `az aks get-credentials --resource-group azure-k8s-dev --name k8s-dev` to get your kube creds
- Let aks talk with the acr run `az aks update -n k8s-dev -g azure-k8s-dev --attach-acr ctdev`
- cd into traefik directory `cd ../traefik`
- Read the ReadMe.md that is located in that directory.
- Create the secret for mySQL and GraphQL sensitive information (sample with default values).
```
kubectl create secret generic server-secret --from-literal=DATABASE_HOST='db' --from-literal=MYSQL_DATABASE='cherrytwist' --from-literal=MYSQL_ROOT_PASSWORD='toor' --from-literal=GRAPHQL_ENDPOINT_PORT='4000' --from-literal=GRAPHQL_SERVER_ENDPOINT_URL='ct-server-service.default' 
```
- Create the secret for WAIT_HOSTS values (sample with default values).
```
kubectl create secret generic wait-hosts --from-literal=WAIT_HOSTS='db.default:3306' --from-literal=WAIT_HOSTS_TIMEOUT='300' --from-literal=WAIT_SLEEP_INTERVAL='30' --from-literal=WAIT_HOSTS_CONNECT_TIMEOUT='30' 
```
- Create a secret for AAD values (Sample with items between <> needing to be replaces). In this example we have two AAD called cherrytwist-web and one called cherrytwist-api. 
```
kubectl create secret generic server-secret --from-literal=REACT_APP_AUTH_CLIENT_ID='<CLIENT_ID from cherrytwist-web >' --from-literal=REACT_APP_AUTH_TENANT_ID='<TENANT_ID from cherrytwist-web>' --from-literal=REACT_APP_AUTH_API_SCOPE='<api://[cherrytwist-api-client-id]/.default>' --from-literal=AAD_TENANT='<SAME_AS_REACT_APP_AUTH_TENANT_ID>' --from-literal=AAD_CLIENT='<client id from cherrytwist-api>'
```

# To Update Github Actions:
- Create an Azure role assignment for the scope of your Azure subscription and resource group.
```
az ad sp create-for-rbac --sdk-auth --role contributor --scopes /subscriptions/{subscription id}/resourceGroups/azure-k8s-dev
```
- Go to the organizational secrets and update the secret `AZURE_CRED_K8S` with the output of the previous command
