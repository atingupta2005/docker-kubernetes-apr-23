cd ~/databricks-k8s-bangalore-mar-23/Hands-On/Kubernetes/03-resource-and-objects/04-02-PODs-with-YAML/

# PODs with YAML
# Create Pod
kubectl apply -f kube-manifests/02-pod-definition.yml

# List Pods
kubectl get pods

# Create Service
kubectl apply -f kube-manifests/03-pod-LoadBalancer-service.yml

# List Service
kubectl get svc

SVC_PUB_IP=$(kubectl get svc myapp-pod-loadbalancer-service -o json | jq .status.loadBalancer.ingress[0].ip)
SVC_PUB_IP2=${SVC_PUB_IP//\"}
echo $SVC_PUB_IP2

# Access Application
curl $SVC_PUB_IP2

kubectl delete -f kube-manifests/02-pod-definition.yml
kubectl delete -f kube-manifests/03-pod-LoadBalancer-service.yml
