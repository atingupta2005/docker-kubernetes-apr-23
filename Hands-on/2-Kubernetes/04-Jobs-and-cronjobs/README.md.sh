cd ~/databricks-k8s-bangalore-mar-23/Hands-On/Kubernetes/04-Jobs-and-cronjobs/

# Kubernetes Job
## How to Create a Kubernetes Job
kubectl apply -f kube-manifests/job.yaml
kubectl get jobs

POD_NAME=$(kubectl get po -o json | jq .items[0].metadata.name)
POD_NAME2=${POD_NAME//\"}
echo $POD_NAME2

kubectl logs -f $POD_NAME2

## How to Create a Kubernetes CronJob
kubectl apply -f kube-manifests/cron-job.yaml
kubectl get cronjobs


kubectl delete -f kube-manifests/
