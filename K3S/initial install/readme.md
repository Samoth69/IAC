# Initial K3S install

## install k3s

```bash
# server
curl -sfL https://get.k3s.io | sh -s - --flannel-backend host-gw --token '[TODO]' --secrets-encryption --selinux --cluster-cidr=172.16.0.0/16,fc00:0::/56 --service-cidr=172.17.0.0/16,fc00:1::/112

# client
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="agent" K3S_TOKEN="[TODO]" sh -s - --server https://k3s.samoth.eu
```

> voir `/var/lib/rancher/k3s/server/token` pour avoir le token du serveur pour connecter des nodes

## lvm sc

```bash
kubectl apply -f https://openebs.github.io/charts/lvm-operator.yaml
```
