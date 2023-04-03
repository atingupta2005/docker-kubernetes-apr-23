# Configure Liveness and Readiness Probes
- The kubelet uses liveness probes to know when to restart a container
- For example, liveness probes could catch a deadlock, where an application is running, but unable to make progress
- Restarting a container in such a state can help to make the application more available

- The kubelet uses readiness probes to know when a container is ready to start accepting traffic

```
kubectl apply -f kube-manifests/
kubectl get all
kubectl delete -f kube-manifests/
```
