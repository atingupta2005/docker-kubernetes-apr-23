cd ~/databricks-k8s-bangalore-mar-23/Hands-On/Kubernetes/11-volumes-configmaps-and-secrets

# Kubernetes - Secrets

# Linux
echo -n 'dbpassword11' | base64
# URL: https://www.base64encode.org

# Create All Objects
kubectl apply -f kube-manifests/


# List Pods
kubectl get pods

sleep 10
# Get Public IP of Application
kubectl get svc usermgmt-webapp-service

SVC_PUB_IP=$(kubectl get svc usermgmt-webapp-service -o json | jq .status.loadBalancer.ingress[0].ip)
SVC_PUB_IP2=${SVC_PUB_IP//\"}
echo $SVC_PUB_IP2


# Access Application
curl $SVC_PUB_IP2
#Username: admin101
#Password: password101


# Delete All
kubectl delete -f kube-manifests/


# List Pods
kubectl get pods


# Verify sc, pvc, pv
kubectl get sc,pvc,pv
