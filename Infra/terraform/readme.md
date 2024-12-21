# pve terraform

```
https://factory.talos.dev/image/a7bcadbc1b6d03c0e687be3a5d9789ef7113362a6a1a038653dfd16283a92b6b/v1.9.0/nocloud-amd64.iso
```

```
customization:
    systemExtensions:
        officialExtensions:
            - siderolabs/qemu-guest-agent
            - siderolabs/util-linux-tools
```

```sh
terraform plan -var-file=vars.tfvars
```
