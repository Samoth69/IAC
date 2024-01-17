# Minio

*Vive les bucket S3*

```bash
kubectl create ns minio
kubectl apply -f minio_secret.yaml

helm upgrade --install my-minio -n minio oci://registry-1.docker.io/bitnamicharts/minio -f values.yaml
kubectl apply -f ingress.yaml
```
