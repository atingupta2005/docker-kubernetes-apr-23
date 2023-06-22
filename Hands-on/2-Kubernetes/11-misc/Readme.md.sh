# Setup autocomplete in bash into the current shell
source <(kubectl completion bash) 
echo "source <(kubectl completion bash)" >> ~/.bashrc

#1.-------Deploy Docker image in Kubernetes
sudo kubectl create deployment hello-world-rest-api --image=atingupta2005/hello-world-rest-api:0.0.1.RELEASE
sudo kubectl expose deployment hello-world-rest-api --type=LoadBalancer --port=8080
sudo kubectl get service
sudo kubectl get pods
sudo kubectl scale deployment hello-world-rest-api --replicas=3
sudo kubectl get pods

#2.--------Pods
#Pod is the smallest deployable unit. Can not have container without Pod. Container lives inside Pod
sudo kubectl get pods
sudo kubectl get pods -o wide

# To get details about the artifact
sudo kubectl explain pods

# Get more details of the pod
sudo kubectl describe pod hello-world-rest-api-58ff5dd898-9trh2	

sudo kubectl get pods
sudo kubectl delete pod hello-world-rest-api-58ff5dd898-62l9d
sudo kubectl get pods

#--------Get list of various artifacts
sudo kubectl get all
sudo kubectl get events
sudo kubectl get pods
sudo kubectl get replicaset
sudo kubectl get deployment
sudo kubectl get service

#3.------Replicaset
kubectl get replicasets
# Since we are telling that how much replicas we need, a replicaset will take care of it.
kubectl scale deployment hello-world-rest-api --replicas=4
kubectl get pods
kubectl get replicaset
kubectl get events --sort-by=.metadata.creationTimestamp
kubectl get rs -o wide

# Lets delete one Pod and see how its auto created. Please note that use correct Pod ID
kubectl delete pod hello-world-rest-api-67c79fd44f-n6c7l
kubectl get pods -o wide
kubectl delete pod hello-world-rest-api-67c79fd44f-8bhdt
kubectl get pods -o wide

#4.------------Deployment
# Deployment ensures the release upgrades without any issue.
# We don’t want to have the downtime while release upgrade and Deployment plays a key role in achieving that
# There are many deployment strategies - Rolling Update
# Whenever we want to deploy new release of our existing application, we desire zero downtime
# If we change the image and that image is not existing, it will not deploy that
kubectl set image deployment hello-world-rest-api hello-world-rest-api=DUMMY_IMAGE:TEST

kubectl get service
# Now if we check in browser the old version is still running

#If we check our replicasets, then there are 2 replicasets. One with old image, other for error image
kubectl get rs -o wide

#We will see that there are 4 Pods, 3 are for old image, and new one has invalid status
kubectl get pods

#Check the details of the error pod
kubectl describe pod hello-world-rest-api-85995ddd5c-msjsm

#Check the series of events and notice in the last that how image has been marked as invalid
kubectl get events --sort-by=.metadata.creationTimestamp

#So there is rolling update is in force, it create 1 more replicaset and initiate 1 pod at a time and deletes 1 pod.
# Now let's set the correct image and see the effect
kubectl set image deployment hello-world-rest-api hello-world-rest-api=atingupta2005/hello-world-rest-api:0.0.2.RELEASE

#Now check in the browser, how the app version is changing gradually
kubectl get service

# Lets see the events which occurred. 
# You will notice that Deployment is regularly updating the replication configuration like:
# Old:2/New:1
# Old:1/New:2
# Old:0/New:3
kubectl get events --sort-by=.metadata.creationTimestamp

# Summary: Deployment is really useful to make sure that we are able to 
# update new releases of application without downtime
# Strategy used by Deployment is called "Rolling Update"

kubectl get pods -o wide
kubectl get rs

#5.---------------Services
#If we delete the Pod then its auto created. Also each time the Private IP of Pod is changed
kubectl delete pod hello-world-rest-api-67c79fd44f-n6c7l
kubectl get pods -o wide
kubectl delete pod hello-world-rest-api-67c79fd44f-8bhdt
kubectl get pods -o wide

#We don't want to give a new IP every time.
#We need a single IP. Kubernetes provides Service for that purpose.
#It does the mapping of Single IP with the POD IP
#Role of the service is to always provide the single IP

kubectl get service -o wide


#------------Auto scale
# To auto scale based on the workload of CPU
kubectl auto scale deployment hello-world-rest-api --max=10 --cpu-percent=70

kubectl set image deployment hello-world-rest-api hello-world-rest-api=atingupta2005/hello-world-rest-api:0.0.2.RELEASE

kubectl get pods

#7.---------- Deploy 01 Spring Boot Hello World Rest API to Kubernetes
#We will just change the image name in existing Deployment and the new release will be published
kubectl set image deployment hello-world-rest-api hello-world-rest-api=atingupta2005/hello-world-rest-api:0.0.4-SNAPSHOT

#Now refresh web page and see that new version is live

#Now let’s see the rollout history of our Deployment
kubectl rollout history deployment hello-world-rest-api

#To record which command was used to change deployment use --record
kubectl set image deployment hello-world-rest-api hello-world-rest-api=atingupta2005/hello-world-rest-api:0.0.4-SNAPSHOT --record

kubectl rollout history deployment hello-world-rest-api

#Check status of the rollout
kubectl rollout status deployment hello-world-rest-api

#We can also undo deployment
kubectl rollout undo deployment hello-world-rest-api --to-revision=3

kubectl rollout status deployment hello-world-rest-api

kubectl rollout undo deployment hello-world-rest-api --to-revision=3

kubectl rollout status deployment hello-world-rest-api

#Lets check the history again
kubectl rollout history deployment hello-world-rest-api

#Let's see the logs of the application
kubectl get pods
kubectl logs hello-world-rest-api-67c79fd44f-d6q9z

#Let's see the logs of the application and follow
kubectl logs hello-world-rest-api-67c79fd44f-d6q9z -f

#To continuously monitor the website every 2 seconds
# Get IP Address
kubectl get service
watch curl http://<ipaddress>:8080/hello-world
# Now duplicate the terminal to run commands on another console. 
# We can also tile the windows so that both will be shown together.


# Now see the logs and focus on the logs generated by curl

#8.-----------Generate Kubernetes YAML Configuration for Deployment and Service
#Till now we have used command line to create our pods and services
#In real world scenario we need to use YAML files

kubectl get deployment hello-world-rest-api

kubectl get deployment hello-world-rest-api -o wide
kubectl get deployment hello-world-rest-api -o yaml
kubectl get deployment hello-world-rest-api -o yaml > deployment.yaml
kubectl get service hello-world-rest-api -o yaml
kubectl get service hello-world-rest-api -o yaml > service.yaml

#9.-----------Understand and Improve Kubernetes YAML Configuration
#In Kubernetes we can define multiple resources in a single file
#We can cut all content from service.yaml and paste in deployment.yaml
#Also cleanup the final file and delete the unnecessary content
#Final cleaned up file:
  - https://raw.githubusercontent.com/atingupta2005/01-hello-world-rest-api/master/backup/deployment-01-after-cleanup.yaml

#Now let's delete the application and deploy using yaml file
#Here we are using the label to delete the resource
kubectl delete all -l app=hello-world-rest-api
kubectl get all
wget https://raw.githubusercontent.com/atingupta2005/01-hello-world-rest-api/master/backup/deployment-01-after-cleanup.yaml
nano deployment-01-after-cleanup.yaml
#----Imp: Make sure to change the ImagePullPolicy to Always
kubectl apply -f deployment-01-after-cleanup.yaml
kubectl get all

#Take the external IP and browse on the website at port 8080
watch kubectl get service

#10.----------------Understanding Kubernetes YAML Configuration - Labels and Selectors
#Open the final yaml file we created previously and understand it.
vim deployment-01-after-cleanup.yaml

#In any yaml file, the important parts are:
 - apiVersion
 - kind
 - metadata
 - spec

# -spec\template is the definition of the POD and details of the container.
  -- imagePullPolicy is to specify what would happen if image is modified or not present.
  -- Available imagePullPolicy options - Always and IfNotPresent
# To match the POD with Deployment labels and selectors are used.

#Now let's change the image tag in the Pod definition.
#- Do the changed in file: 
 - deployment-01-after-cleanup.yaml

nano deployment-01-after-cleanup.yaml

#We can check if there is any difference in deployed environment with our yaml file
kubectl diff -f deployment-01-after-cleanup.yaml

#If there are any changes we can deploy the configuration using yaml file
kubectl apply -f deployment-01-after-cleanup.yaml

#11.-----------------------Reduce release downtime with minReadySeconds
#When we update the image tag to update the release, there is a few seconds downtime
#To boot up a POD, it might take time and Kubernetes just assumes that since the new pod is now running, it deletes the old pod.
#New POD is running but it might take time to load the services inside it.
#Its better to tell Kubernetes to wait for some seconds before deleting the old POD

# To solve it specify below parameter inside spec: in yaml file -> spec.minReadySeconds above template tag:

minReadySeconds: 45

kubectl apply -f deployment-01-after-cleanup.yaml

# Notice that the downtime is now reduced


#12.-----------------Understanding Replica Sets in Depth - Using Kubernetes YAML Config
#Replicaset can work independent of Deployment
#If we only use Replicaset, then it would only focus on maintaining the required number replicas
#Replicaset do not work for revision upgrades if image name is changed
wget https://raw.githubusercontent.com/atingupta2005/01-hello-world-rest-api/master/backup/deployment-02-using-replica-set.yaml
#Now use command:
kubectl get all
kubectl delete all -l app=hello-world-rest-api
kubectl delete horizontalpodautoscaler.autoscaling/hello-world-rest-api

# It’s in fact Replicaset definition only. Check the kind property
nano deployment-02-using-replica-set.yaml

kubectl apply -f deployment-02-using-replica-set.yaml

kubectl get svc

watch -n 0.1 curl http://52.191.33.131:8080/hello-world

#We don't see the deployment
kubectl get all  

#If we change the image tag/name then below command will have no impact:
nano deployment-02-using-replica-set.yaml
kubectl get all
kubectl apply -f deployment-02-using-replica-set.yaml
kubectl get all   #We don't see the deployment

#We will not see any new pods as Replicaset only cares for maintaining number of replicas as needed
kubectl get pods 

#Now update the revision by deleting the pod:
kubectl delete pod <>

# New pod with new version if now created
kubectl get pods
kubectl get service
#Watch the curl output and notice that version is coming different as only 1 pod is updated with new image
watch http:<ip>:8080

kubectl delete pod <>  # Delete another older pod also
kubectl get pods    #Both the pods are now having latest release

#So it’s better to use deployment if we need automatic updates

#13.----------------Configure Multiple Kubernetes Deployments with One Service
#We can configure the connect a service to the pods using selectors.
#Each artifact in Kubernetes is assigned label/values.
#These label/values are used by other artifacts as selectors
kubectl delete all -l app=hello-world-rest-api


#Modify the file deployment-03-Multiple-Deployments-With-Same-Service.yaml to remove selector from service
#Below is the modified file
wget https://raw.githubusercontent.com/atingupta2005/01-hello-world-rest-api/master/backup/deployment-03-Multiple-Deployments-With-Same-Service.yaml

#Remove the label selector from the service to select multiple pods 
nano deployment-03-Multiple-Deployments-With-Same-Service.yaml
kubectl get all

kubectl apply -f deployment-03-Multiple-Deployments-With-Same-Service.yaml

# Get the External IP
kubectl get service
watch curl http://<externalIP>:8080/hello-world

# Notice that how the version of app is getting changed

#17.-------------Playing with Kubernetes Commands - Top Node and Pod
#Fetches PODS from all namespaces
kubectl get pods --all-namespaces

#Fetches PODS of specific label from current namespace
kubectl get pods -l app=todo-web-application-h2

#Fetches PODS of specific label from all namespaces
kubectl get pods -l app=todo-web-application-h2 --all-namespaces

kubectl get services --all-namespaces

kubectl get services --all-namespaces --sort-by=.spec.type

kubectl get services --all-namespaces --sort-by=.metadata.name

#To get details of the various things running in the cluster
kubectl cluster-info

#To get the utilization details of the nodes
kubectl top node

#To get the utilization details of the pods
kubectl top pod

#Short commands
kubectl get services
kubectl get svc
kubectl get ev  #Events 
kubectl get rs  # Replicaset

kubectl get ns  #Namespace
kubectl get nodes
kubectl get no  #Nodes
kubectl get po  #Pods

#----------Auto Scaling
#Horizontal
#Vertical
#Can scale as per:
 - Cluster Autoscaling: Number of Nodes. While creating the Cluster enable the autoscaling features
 - Horizontal POD Autoscaling: Number of Pods
 - Vertical POD Autoscaling: Increase resources(RAM?CPU) of the POD. Need to specify while creating the cluster

#Horizontal POD Autoscaling 
wget -O deploment_currency_exchange_autoscale.yaml https://raw.githubusercontent.com/atingupta2005/04-currency-exchange-microservice-basic/master/deployment.yaml
vim deploment_currency_exchange_autoscale.yaml

#Review the file for autoscaling features
## Modify the CPU usage Limists. Min 100, max 500
kubectl apply -f deploment_currency_exchange_autoscale.yaml
kubectl get pods
kubectl logs <podID> -f
kubectl top pods
watch -n 0.1 curl http://<service_ip>:8000/currency-exchange/from/EUR/to/INR
#watch -n 0.1 curl http://<service_ip>:8000/currency-conversion/from/EUR/to/INR/quantity/10
watch -n 0.1 kubectl top pods

#Let's autoscale deployment based on CPU usage
kubectl autoscale deployment currency-exchange --min=1 --max=3 --cpu-percent=10

watch -n 0.1 kubectl get pods  # PODS will be created/deleted automatically based on the Load

#Let' see the events.
kubectl get events

#Review the content and delete metadata

#Extra commands:
#Generally when the status of your pod is ImgaePullBackOff the sytem automatically tries to 
#re-pull the image in a matter of minutes, 
#if you actually want to restart the pod then 
#you'll probably have to delete the pod and recreate it.
kubectl replace --force -f <pod yaml file>

kubectl delete --all namespaces
kubectl delete --all deployments --namespace=foo
kubectl delete pods --all
kubectl delete deployment --all
kubectl delete rc --all
kubectl delete rs --all
kubectl delete service -l provider=fabric8
kubectl delete secret -l provider=fabric8
kubectl delete ingress --all
kubectl delete configmap --all
kubectl delete sa --all


#Restart Deployment
kubectl rollout restart <deployment-name>
#We can just scale down and scale up to redeploy
kubectl scale deployment todo-web-application --replicas=0
kubectl scale deployment todo-web-application --replicas=1

#Referenes:
Cheatcheat:
https://kubernetes.io/docs/reference/kubectl/cheatsheet/
