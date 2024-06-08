# Superset

```bash
helm repo add superset https://apache.github.io/superset
kubectl create ns superset
helm -n superset install superset superset/superset -f values.yaml
```
