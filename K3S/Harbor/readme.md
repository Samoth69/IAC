# Harbor

```bash
kubectl create ns harbor

kubectl -n harbor apply -f database.yaml
kubectl -n harbor apply -f ingressRoute.yaml

helm repo add harbor https://helm.goharbor.io
helm upgrade --install harbor harbor/harbor --values values.yaml -n harbor
```