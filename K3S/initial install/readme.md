# Initial K3S install

## install k3s

```bash
curl -sfL https://get.k3s.io | sh -s - --flannel-backend host-gw --secrets-encryption --selinux
```

> voir `/var/lib/rancher/k3s/server/token` pour avoir le token du serveur pour connecter des nodes

## storage class

local

```bash

```