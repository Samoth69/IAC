# Initial K3S install

## install k3s

```bash
# server
curl -sfL https://get.k3s.io | sh -s - --flannel-backend host-gw --secrets-encryption --tls-san 192.168.0.30 --selinux --cluster-cidr=172.16.0.0/16,fc00:0::/56 --service-cidr=172.17.0.0/16,fc00:1::/112 --resolv-conf /etc/resolv-custom.conf

# client
# curl -sfL https://get.k3s.io | sh -s - agent --token '' --server https://192.168.5.2:6443 --selinux --resolv-conf /etc/resolv-custom.conf
```

## auto upgrade

```bash
kubectl apply -f https://github.com/rancher/system-upgrade-controller/releases/latest/download/system-upgrade-controller.yaml
kubectl apply -f https://github.com/rancher/system-upgrade-controller/releases/download/v0.13.4/crd.yaml
```

- marche pas pour des histoires de certificats, faut mettre à jour à la main la version dans [auto-upgrade.yaml](auto-upgrade.yaml)
- voir la dernière version stable dispo [ici](https://update.k3s.io/v1-release/channels)

```bash
kubectl apply -f auto-upgrade.yaml
```
