# Ephemeral Volumes
- Some application need additional storage but don't care whether that data is stored persistently across restarts
- For example, caching services
- Ephemeral volumes are designed for these use cases
- Refer: kube-manifests/ephemeral-volume.yaml
```
kubectl apply -f kube-manifests/
kubectl get pods
kubectl delete -f kube-manifests/
```
