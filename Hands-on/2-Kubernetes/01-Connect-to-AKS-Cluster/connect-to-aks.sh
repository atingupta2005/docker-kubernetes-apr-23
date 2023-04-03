AKS_NAME="akstrng"
AKS_RG="rgtrngaks"
mylocation="EASTUS"

az login -u <user-id>@atingupta2005gmailcom.onmicrosoft.com -p <Password>
az account set --subscription "cab7799e-bdd5-4b31-a003-c56612e38f3e"

#- Connect to AKS (If Required)
az aks get-credentials --resource-group $AKS_RG --name $AKS_NAME --admin --overwrite-existing

# Install Kubectl (First time)
#sudo snap install kubectl --classic

kubectl create namespace "ns-$USER"

kubectl config set-context --current --namespace="ns-$USER"

kubectl get namespaces

# Get all my pods
kubectl get pods
