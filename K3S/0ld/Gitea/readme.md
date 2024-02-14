# Gitea

```bash
helm repo add gitea-charts https://dl.gitea.com/charts/
helm repo update
kubectl create ns gitea
kubectl apply -f secrets.yaml
kubectl -n gitea apply -f database.yaml
helm upgrade --install redis oci://registry-1.docker.io/bitnamicharts/redis -n gitea -f values_redis.yaml
helm upgrade --install gitea gitea-charts/gitea -n gitea -f values_gitea.yaml
```