# Kubernetes  - PODs
# Get Worker Node Status
kubectl get nodes

# Get Worker Node Status with wide option
kubectl get nodes -o wide

### Create a Pod
#### Replace Pod Name, Container Image
kubectl run $USER-first-pod --image atingupta2005/kubenginx:1.0.0

# List Pods
## List Pods
kubectl get pods

# Describe the Pod
kubectl describe pod $USER-first-pod

# Delete Pod
kubectl delete pod $USER-first-pod

# Expose Pod with a Service
# Create  a Pod
kubectl run $USER-first-pod --image atingupta2005/kubenginx:1.0.0

# Expose Pod as a Service
kubectl expose pod $USER-first-pod  --type=LoadBalancer --port=80 --name=$USER-first-service

# Describe Service
kubectl describe service $USER-first-service

SVC_PUB_IP=$(kubectl get svc $USER-first-service -o json | jq .status.loadBalancer.ingress[0].ip)
SVC_PUB_IP2=${SVC_PUB_IP//\"}
echo $SVC_PUB_IP2

# Access Application
curl $SVC_PUB_IP2

# Stream pod logs with -f option and access application to see logs
kubectl logs -f $USER-first-pod

# Connect to Nginx Container in a POD
kubectl exec -it $USER-first-pod -- /bin/bash

# Execute some commands in Nginx container
ls
cd /usr/share/nginx/html
cat index.html
exit


### Get YAML Output

# Get pod definition YAML output
kubectl get pod $USER-first-pod -o yaml


# Get service definition YAML output
kubectl get service $USER-first-service -o yaml

# Get all Objects in default namespace
kubectl get all

# Delete Services
kubectl delete svc $USER-first-service

# Delete Pod
kubectl delete pod $USER-first-pod
