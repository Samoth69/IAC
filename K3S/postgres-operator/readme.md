# postgres operator

by Zalando.com

-> https://postgres-operator.readthedocs.io/en/latest/quickstart/
-> https://postgres-operator.readthedocs.io/en/latest/reference/operator_parameters/ https://github.com/zalando/postgres-operator/blob/master/manifests/postgresql-operator-default-configuration.yaml
TODO: voir pour ajouter de l'auth sur la page

```bash
kubectl create namespace postgres-operator
helm upgrade --install postgres-operator postgres-operator-charts/postgres-operator -n postgres-operator

kubectl create namespace postgres-operator-ui
helm install postgres-operator-ui postgres-operator-ui-charts/postgres-operator-ui -n postgres-operator-ui
```
