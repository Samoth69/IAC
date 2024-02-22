# Tailscale

il est question ici de configurer tailscale pour avoir les CI github qui tapes sur Harbor pour pouvoir pousser les images docker qui vont bien

-> https://tailscale.com/kb/1236/kubernetes-operator

```bash
helm repo add tailscale https://pkgs.tailscale.com/helmcharts
helm repo update
helm upgrade \
  --install \
  tailscale-operator \
  tailscale/tailscale-operator \
  --namespace=tailscale \
  --create-namespace \
  --set-string oauth.clientId=<OAauth client ID> \
  --set-string oauth.clientSecret=<OAuth client secret> \
  --wait
```