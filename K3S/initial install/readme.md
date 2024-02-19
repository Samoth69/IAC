# Initial K3S install

## install k3s

```bash
# server
curl -sfL https://get.k3s.io | sh -s - --flannel-backend host-gw --token '' --secrets-encryption --selinux --cluster-cidr=172.16.0.0/16,fc00:0::/56 --service-cidr=172.17.0.0/16,fc00:1::/112 --resolv-conf /etc/resolv-custom.conf --disable local-storage

# client
curl -sfL https://get.k3s.io | sh -s - agent --token '' --server https://192.168.5.2:6443 --selinux --resolv-conf /etc/resolv-custom.conf
```

## lvm sc

```bash
kubectl apply -f https://openebs.github.io/charts/lvm-operator.yaml
kubectl apply -f sc_lvm.yml
kubectl apply -f traefik_secret.yml
```

https://github.com/openebs/lvm-localpv/blob/develop/docs/thin_provision.md#configure-auto-extending-of-the-thin-pool-configure-over-provisioning-protection