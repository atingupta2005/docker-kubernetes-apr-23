kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml

kubectl get all -n kubernetes-dashboard
kubectl edit service/kubernetes-dashboard -n kubernetes-dashboard
kubectl get svc -n kubernetes-dashboard
kubectl apply -f k8s-serviceaccount.yml
kubectl describe sa dashboard-admin -n kubernetes-dashboard
kubectl get secrets -n kubernetes-dashboard
kubectl describe  secrets dashboard-admin-token  -n kubernetes-dashboard
kubectl get svc -n kubernetes-dashboard

curl https://<ip-address>

kubectl delete -f k8s-serviceaccount.yml
kubectl delete -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml
