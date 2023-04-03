cd ~/databricks-k8s-bangalore-mar-23/Hands-On/Kubernetes/06-Persistent-and-ephemeral-volumes/05-01-SC-PVC-ConfigMap-MySQL

# AKS Storage -  Storage Classes, Persistent Volume Claims
# Create Storage Class
kubectl apply -f kube-manifests/01-storage-class.yml

### Create Persistent Volume Claims
kubectl apply -f kube-manifests/02-persistent-volume-claim.yml


# List Storage Classes
kubectl get sc

# List PVC # It will show Pending
kubectl get pvc

# List PV # It will show No Resource
kubectl get pv

### Create ConfigMap manifest
# - We are going to create a `usermgmt` database schema during the mysql pod creation time which we will leverage when we deploy User Management Microservice.

### Create MySQL Deployment manifest
# - Environment Variables
# - Volumes
# - Volume Mounts

### Create MySQL ClusterIP Service manifest
# - At any point of time we are going to have only one mysql pod in this design so `ClusterIP: None` will use the `Pod IP Address` instead of creating or allocating a separate IP for `MySQL Cluster IP service`.

# Create MySQL Database
kubectl apply -f kube-manifests/

# List Storage Classes
kubectl get sc

# List PVC
kubectl get pvc


# List PV
kubectl get pv


# List pods
kubectl get pods


# List pods based on  label name
kubectl get pods -l app=mysql


## Connect to MySQL Database

# Connect to MYSQL Database
kubectl run -it --rm --image=mysql:5.6 --restart=Never mysql-client -- mysql -h mysql -pdbpassword11


# Verify usermgmt schema got created which we provided in ConfigMap
show schemas;
exit

## Step-05: Clean-Up

# Delete All
kubectl delete -f kube-manifests/


## Step-06: Delete PV exclusively - It exists due to retain policy

# List PV
kubectl get pv
PV_NAME=$(kubectl get pv -o json | jq .items[0].metadata.name)
PV_NAME2=${PV_NAME//\"}
echo $PV_NAME2

# Delete PV exclusively
kubectl delete pv $PV_NAME2

# Delete Azure Disks
# Go to All Services -> Disks -> Select and Delete the Disk
