cd ~/databricks-k8s-bangalore-mar-23/Hands-On/Kubernetes/06-Persistent-and-ephemeral-volumes/05-02-UserMgmt-WebApp-with-MySQLDB/

# Deploy UserManagement Web Application with MySQL Database

# Create Deployment & LoadBalancer Service
kubectl apply -f kube-manifests/

sleep 10

# List Pods
kubectl get pods
POD_NAME=$(kubectl get pods -o json | jq .items[0].metadata.name)
POD_NAME2=${POD_NAME//\"}
echo $POD_NAME2

# Verify logs of Usermgmt Web Application Pod
kubectl logs -f $POD_NAME2    # Press CTRL+C to come out


# Verify sc, pvc, pv
kubectl get sc,pvc,pv


#- **Access Application**

# List Services
kubectl get svc usermgmt-webapp-service

SVC_PUB_IP=$(kubectl get svc usermgmt-webapp-service -o json | jq .status.loadBalancer.ingress[0].ip)
SVC_PUB_IP2=${SVC_PUB_IP//\"}
echo $SVC_PUB_IP2

# Access Application
curl $SVC_PUB_IP2
#Username: admin101
#Password: password101


# Connect to MYSQL Database
kubectl run -it --rm --image=mysql:5.6 --restart=Never mysql-client -- mysql -h mysql -pdbpassword11


# Verify usermgmt schema got created which we provided in ConfigMap
show schemas;
use webappdb;
show tables;
select * from user;
exit

# Delete All
kubectl delete -f kube-manifests/


# List Pods
kubectl get pods


# Verify sc, pvc, pv
kubectl get sc,pvc,pv


# Delete PV Exclusively
kubectl get pv
PV_NAME=$(kubectl get pv -o json | jq .items[0].metadata.name)
PV_NAME2=${PV_NAME//\"}
echo $PV_NAME2

kubectl delete pv $PV_NAME2

#- Delete Azure Disks
#  - Go to All Services -> Disks -> Select and Delete the Disk
