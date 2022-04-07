# ElasticSearch AKS Demo

Demo to run and test ElasticSearch in Azure Kubernetes Service. **Not production ready! Still need lots of changes!**

## Prerequesties
```
## Deployment guide
* [Azure Kubernetes Services](https://)
* [Docker](https://)
* [Docker Compose](https://)
* [Kind](https://)

## Create certificate

## Create test data
```bash
sh  scripts/create_test_data.sh
```

## Tips and tricks
```bash
# Get elastic search and kibana info including health, version and number of nodes
kubectl get elasticsearch
kubectl get kibana

# Monitor the operator logs
kubectl -n elastic-system logs -f statefulset.apps/elastic-operator

# Access pod logs
kubectl logs -f elasticsearch-es-node-0
kubectl logs -f elasticsearch-es-node-1
```
## Useful links
* [Running the Elastic Stack on Kubernetes with ECK (YouTube)] (https://www.youtube.com/watch?v=Wf6E3vkvEFM)
* [Offical www.elastic.co guide](https://www.elastic.co/guide/en/cloud-on-k8s/1.9/k8s-overview.html)