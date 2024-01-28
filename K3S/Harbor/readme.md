# Harbor

```bash
kubectl create ns harbor

kubectl -n harbor apply -f database.yaml

helm repo add harbor https://helm.goharbor.io
helm upgrade --install my-harbor harbor/harbor --values values.yaml -n harbor
```