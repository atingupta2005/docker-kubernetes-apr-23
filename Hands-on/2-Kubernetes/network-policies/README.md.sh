## Example: LIMIT traffic to an application
### Use Case:
#- Restrict traffic to a service only to other microservices that need to use it.
#- Restrict connections to a database only to the application using it.

#- Suppose your application is a REST API server, marked with labels app=bookstore and role=api:
kubectl run apiserver --image=nginx --labels="app=bookstore,role=api" --expose --port=80

# Create NetworkPolicy
kubectl apply -f kube-manifests/

# Test the Network Policy is blocking the traffic, by running a Pod without the app=bookstore label:
## Traffic is blocked!
kubectl run test-$RANDOM --rm -i -t --image=alpine -- sh
wget -qO- --timeout=2 http://apiserver
exit

# Test the Network Policy is allowing the traffic, by running a Pod with the app=bookstore label:
## Traffic is allowed
kubectl run test-$RANDOM --rm -i -t --image=alpine --labels="app=bookstore,role=frontend" -- sh
wget -qO- --timeout=2 http://apiserver
exit

# Cleanup
kubectl delete -f kube-manifests/
kubectl delete pod apiserver
kubectl delete service apiserver
kubectl get all
