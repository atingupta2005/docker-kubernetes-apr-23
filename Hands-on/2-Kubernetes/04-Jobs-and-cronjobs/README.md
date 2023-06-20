# Kubernetes Job
## What is a Kubernetes Job?
- Short-lived and batch workloads.

## Kubernetes Jobs & CronJobs Use Cases
- Batch processing
  - Let’s say you want to run a batch task once a day or during a specific schedule
  - It could be something like reading files from storage or a database and feed them to a service to process the files.
- Operations/ad-hoc tasks
  - Let’s say you want to run a script/code which runs a database cleanup activity or to even backup a kubernetes cluster itself

## How to Create a Kubernetes Job
- Refer: kube-manifests/job.yaml

```
kubectl apply -f kube-manifests/job.yaml
kubectl get jobs
kubectl get po
kubectl logs kubernetes-job-example* -f
```

## How to Create a Kubernetes CronJob
- Refer: kube-manifests/cron-job.yaml

```
kubectl apply -f kube-manifests/cron-job.yaml
kubectl get cronjobs
```
