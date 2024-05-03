# GitLab

```bash
helm repo add gitlab https://charts.gitlab.io/
kubectl create ns gitlab
kubectl apply -n gitlab -f database.yaml
helm upgrade --install gitlab -n gitlab gitlab/gitlab --timeout 600s -f values_gitlab.yaml
```

## Pour les maj

- voir [ici](https://docs.gitlab.com/charts/installation/upgrade.html)

```bash
helm repo update
helm upgrade --install gitlab -n gitlab gitlab/gitlab --timeout 600s -f values_gitlab.yaml --version 7.9.2 --set gitlab.migrations.enabled=true
```