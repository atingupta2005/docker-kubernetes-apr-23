# Kubernetes - Requests and Limits

## Introduction
- We can specify how much each container in a pod needs the resources like CPU & Memory.
- When we provide this information in our pod, the scheduler uses this information to decide which node to place the Pod on based on availability of k8s worker Node CPU and Memory Resources.
- When you specify a resource limit for a Container, the kubelet enforces those `limits` so that the running container is not allowed to use more of that resource than the limit you set.
-  The kubelet also reserves at least the `request` amount of that system resource specifically for that container to use.

## Add Requests & Limits & Review k8s Manifests
```yaml
          # Requests & Limits    
          resources:
            requests:
              cpu: "100m"
              memory: "128Mi"
            limits:
              cpu: "200m"
              memory: "256Mi"                                                         
```

## Create k8s objects & Test
```
# Create All Objects
kubectl apply -f kube-manifests-v1/
```
```
# List Pods
kubectl get pods
```
```
# List Services
kubectl get svc
```
```
# Access Application
curl http://<Public-IP-from-List-Services-Output>/app1/index.html
```
## Clean-Up
- Delete all k8s objects created as part of this section
```
# Delete All
kubectl delete -f kube-manifests-v1/
```
