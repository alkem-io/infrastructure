# Infrastructure
Creates deployments, managing infrastructure scripts, devops, monitoring, ...

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
kubectl create secret generic server-secret --from-literal=DATABASE_HOST='db' --from-literal=MYSQL_DATABASE='cherrytwist' --from-literal=MYSQL_ROOT_PASSWORD='toor' --from-literal=GRAPHQL_ENDPOINT_PORT='4000' --from-literal=GRAPHQL_SERVER_ENDPOINT_URL='ct-server-deployment.default'
```
- Create the secret for WAIT_HOSTS values (sample with default values).
```
kubectl create secret generic wait-hosts --from-literal=WAIT_HOSTS='db.default:3306' --from-literal=WAIT_HOSTS_TIMEOUT='300' --from-literal=WAIT_SLEEP_INTERVAL='30' --from-literal=WAIT_HOSTS_CONNECT_TIMEOUT='30' 
```