cd ~/databricks-k8s-bangalore-mar-23/Hands-On/Kubernetes/10-Requests-Limits-and-quotas/

# Kubernetes - Requests and Limits

# Create All Objects
kubectl apply -f kube-manifests/


# List Pods
kubectl get pods

POD_NAME=$(kubectl get pods -o json | jq .items[0].metadata.name)
POD_NAME2=${POD_NAME//\"}
echo $POD_NAME2

#Check limits
kubectl describe pod $POD_NAME2

sleep 10

kubectl get svc app1-nginx-clusterip-service

# List Services
PUBLIC_IP=$(kubectl get svc app1-nginx-clusterip-service -o json | jq .status.loadBalancer.ingress[0].ip)
PUBLIC_IP2=${PUBLIC_IP//\"}
echo $PUBLIC_IP2


# Access Application
echo "curl http://$PUBLIC_IP2/app1/index.html"
curl http://$PUBLIC_IP2/app1/index.html

# Delete All
kubectl delete -f kube-manifests/
