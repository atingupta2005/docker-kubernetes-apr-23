cd ~/databricks-k8s-bangalore-mar-23/Hands-On/Kubernetes/03-resource-and-objects/04-03-Deployments-with-YAML/

# Deployments with YAML
# Create Deployment

kubectl create namespace "ns-$USER"

kubectl config set-context --current --namespace="ns-$USER"

kubectl apply -f kube-manifests/02-deployment-definition.yml

kubectl get deploy


kubectl get rs


kubectl get pods


# Create LoadBalancer Service
kubectl apply -f kube-manifests/03-deployment-LoadBalancer-service.yml


# List Service
kubectl get svc deployment-loadbalancer-service

SVC_PUB_IP=$(kubectl get svc deployment-loadbalancer-service -o json | jq .status.loadBalancer.ingress[0].ip)
SVC_PUB_IP2=${SVC_PUB_IP//\"}
echo $SVC_PUB_IP2

kubectl get po


# Access Application
curl $SVC_PUB_IP2

# Cleanup
kubectl delete -f kube-manifests/
