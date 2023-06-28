# Ingress - Context Path Based Routing

# Deploy Apps
kubectl apply -R -f kube-manifests/

# List Pods
kubectl get pods

# List Services
kubectl get svc

# List Ingress
kubectl get ingress ingress-cpr

LOAD_BALANCER_IP=$(kubectl get ingress ingress-cpr -o json | jq .status.loadBalancer.ingress[0].ip)
LOAD_BALANCER_IP2=${LOAD_BALANCER_IP//\"}
echo $LOAD_BALANCER_IP2


## Access Applications
# Access App1
curl http://$LOAD_BALANCER_IP2/app1/index.html

# Access App2
curl http://$LOAD_BALANCER_IP2/app2/index.html

# Delete Apps
kubectl delete -R -f kube-manifests/
