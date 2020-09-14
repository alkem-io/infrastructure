## To deploy traefik 

- Ensure that the following line is uncommented in traefik-deployment resource. Right 
now you are using staging env to obtain certificates. On main let's encrypt 
you have only 5 requests per hour before you will be banned and it is not recommended to use production env for testing.
```yaml
            - --certificatesresolvers.default.acme.caserver=https://acme-staging-v02.api.letsencrypt.org/directory
```

- Run the following command and create all the resource objects except ingress-route

```bash
$ kubectl apply -f 00-resource-crd-definition.yml,05-traefik-rbac.yml,10-service-account.yaml,15-traefik-deployment.yaml,20-traefik-service.yaml
```

- Get the IP of the Traefik Service exposed as Load Balancer
```bash
$ kubectl get service
NAME         TYPE           CLUSTER-IP      EXTERNAL-IP    PORT(S)                                     AGE
kubernetes   ClusterIP      10.109.0.1      <none>         443/TCP                                     6h16m
traefik      LoadBalancer   35.238.72.172   34.69.16.102   80:32318/TCP,443:32634/TCP,8080:32741/TCP   70s
```

- Create a DNS record for this IP
```bash
$ nslookup k8straefiktlstest.gotdns.ch
Server:         192.168.1.1
Address:        192.168.1.1#53

Non-authoritative answer:
Name:   k8straefiktlstest.gotdns.ch
Address: 35.238.72.172
```

- Create the resource ingress-route
```bash
$ kubectl apply -f 35-ingress-route.yaml
ingressroute.traefik.containo.us/simpleingressroute created
ingressroute.traefik.containo.us/ingressroutetls created
```

##  Next Steps 
- Delete the traefik deployment
```bash
kubectl delete -f 15-traefik-deployment.yaml
```

- Let's remove the Fake part in our cert. In order to do that you would need to comment out the line
```yaml
#            - --certificatesresolvers.default.acme.caserver=https://acme-staging-v02.api.letsencrypt.org/directory
```

- Once the line is commented out, you lets recreate the deployment
```bash
kubectl apply -f 15-traefik-deployment.yaml
```
    
This was a great github repo that helped with traefik v2.0:
`https://github.com/codeaprendiz/kubernetes-kitchen/tree/master/gcp/task-007-traefik-whoami-lets-encrypt`
