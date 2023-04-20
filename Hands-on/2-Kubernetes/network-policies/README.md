# AKS Network Policies
- Network policies are used to control the traffic requests from and into our Pods.
- By default, pods can accept traffic from any source
- We would however not want any traffic sending requests to our pods
- Hence the need for a Network policy.

## What is a Network Policy
- Network policies simply are rules that control traffic from and to the Pod
- A rule can be for instance allowing Pod A to Communicate to B but B cannot communicate to A.

## How to Create a Network Policy
- Network Policy is created with the help of label selectors
- The NetworkPolicy applies to pods that match its label selector.
- When creating a Network Policy there is the question of who and which.
- Which direction is the traffic coming from and which traffic is the traffic going to.
    - (Ingress and Egress)

##NetworkPolicy Definition
```
apiVersion: networking.K8s.io/v1
kind: NetworkPolicy
metadata:
    name: demo-network-policy
    namespace: mynamespace
spec:
 podSelector:
   matchLabels:
      app: database #policy applies to pods with app:database label
   policyTypes:
      - Ingress
      - Egress
      ingress:
       - from:
         - podSelector:
            matchLabels:
               app: webserver #allows incoming connection from pods with app: webserver label
         ports:
           - port: 3306
       egress:
         -to:
          ...
```

- By default pods in a given namespace can be accessed by anyone
- When you create a NetworkPolicy in a certain namespace no one can connect to any pod in that namespace unless their labels match with the one specified in the NetworkPolicy
- For instance, in a namespace with many pods, you would want only one pod to connect to your database
- You would, therefore, create a NetworkPolicy that applies to labels matching the database labels.

## Example: LIMIT traffic to an application
### Use Case:
- Restrict traffic to a service only to other microservices that need to use it.
- Restrict connections to a database only to the application using it.

- Suppose your application is a REST API server, marked with labels app=bookstore and role=api:
```
kubectl run apiserver --image=nginx --labels="app=bookstore,role=api" --expose --port=80
```

- Save the following NetworkPolicy to api-allow.yaml to restrict the access only to other pods (e.g. other microservices) running with label app=bookstore:
```
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: api-allow
spec:
  podSelector:
    matchLabels:
      app: bookstore
      role: api
  ingress:
  - from:
      - podSelector:
          matchLabels:
            app: bookstore
```

- Create NetworkPolicy
```
kubectl apply -f kube-manifests/
```

- Test the Network Policy is blocking the traffic, by running a Pod without the app=bookstore label:
```
kubectl run test-$RANDOM --rm -i -t --image=alpine -- sh
```

```
# wget -qO- --timeout=2 http://apiserver
```

- Traffic is blocked!

- Test the Network Policy is allowing the traffic, by running a Pod with the app=bookstore label:
```
kubectl run test-$RANDOM --rm -i -t --image=alpine --labels="app=bookstore,role=frontend" -- sh
```
```
wget -qO- --timeout=2 http://apiserver
```

```
<!DOCTYPE html>
<html><head>
```

- Traffic is allowed
