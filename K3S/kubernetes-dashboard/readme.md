# install

```bash
helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard -f values.yml
kubectl -n kubernetes-dashboard apply -f dashboard.yml
```

## usage

```bash
kubectl -n kubernetes-dashboard create token admin-user

kubectl -n kubernetes-dashboard get pods
kubectl -n kubernetes-dashboard port-forward kubernetes-dashboard-798dd48467-6qg6b 8000:8000
```
