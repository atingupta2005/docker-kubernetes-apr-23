cd ~/databricks-k8s-bangalore-mar-23/Hands-On/Kubernetes/06-Persistent-and-ephemeral-volumes/05-03-Ephemeral-Volumes

kubectl apply -f kube-manifests/

kubectl get pods

kubectl exec -it myvolumes-pod -- sh
cd /tmp
touch myfile.txt
ls -al

exit

kubectl delete -f kube-manifests/
