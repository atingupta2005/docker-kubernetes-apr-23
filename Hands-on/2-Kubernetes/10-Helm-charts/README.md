# Helm Charts

## What is?
- The package manager for Kubernetes; Helm is the best way to find, share, and use software built for Kubernetes
- A tool for Kubernetes packages called charts
- A chart contains pre-configured Kubernetes resources such as ConfigMaps, Deployments , and StatefulSet manifests, PersistentVolumes , and editable settings for them
- As such, a chart may be seen as a bundle of resources that, if connected together, can create a complex Kubernetes deployment with multiple prerequisites
- Charts are the convenient way to tell the Kubernetes api-server which resources a given application needs to properly run in Kubernetes.

## Chart Structure
```
├── Chart.yaml (meta info about chart)
├── templates (the actual template files)
│   ├── service.yaml
│   └── replicaset.yaml
├── charts (chart dependencies)
│   ├── nginx-ingress-1.1.2.tgz
├── requirements.yaml
└── values (values for template files)
```
