# Keel

*Par ce que mettre à jour c'est important*

```bash
helm repo add keel https://charts.keel.sh 
helm repo update

kubectl create ns keel
kubectl -n keel apply -f secret.yaml
helm upgrade --install keel keel/keel -n keel -f values.yaml
```
