kubectl nodes -o wide
kubectl describe node <node-name> | grep Taint
kubectl taint nodes <node-name> example-key=example-value:NoSchedule
kubectl describe node <node-name> | grep Taint
kubectl nodes -o wide

kubectl apply -f 01-pod.yaml

kubectl pods -o wide
kubectl describe pod nginx

# Now taint the node with different key 
kubectl taint nodes <node-name> example-key:NoSchedule-
kubectl taint nodes <node-name> example-key=another-value:NoExecute
kubectl describe node <node-name> | grep Taint

kubectl describe pod nginx

# How to remove Taint on the node?
kubectl taint nodes <node-name> example-key:NoExecute-
kubectl describe node <node-name> | grep Taint

kubectl describe pod nginx

kubectl delete -f 01-pod.yaml
