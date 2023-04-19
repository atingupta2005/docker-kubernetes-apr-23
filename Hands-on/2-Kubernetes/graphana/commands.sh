cd

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm repo add grafana https://grafana.github.io/helm-charts

helm repo update

kubectl create namespace monitoring

helm install prometheus prometheus-community/prometheus --namespace monitoring --set alertmanager.persistentVolume.storageClass="default" --set server.persistentVolume.storageClass="default"

helm install grafana grafana/grafana --namespace monitoring --set persistence.storageClassName="default" --set persistence.enabled=true --set adminPassword='Azure@123456' --values https://gist.githubusercontent.com/mysticrenji/81d7c046de569f63c210fe89c96ade0d/raw/1e14d8330f2aac5a5f35bb9ed373c26bf46a2bba/datasource-grafana.yaml --set service.type=LoadBalancer

export SERVICE_IP=$(kubectl get svc --namespace monitoring grafana -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

echo http://$SERVICE_IP:80