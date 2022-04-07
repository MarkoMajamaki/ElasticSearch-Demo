# Deploy to local Kind kubernetes cluster

## Deploy
```bash
# Create cluster with config
kind create cluster --name elasticsearch-demo --config deploy/kind/kind.config

# Build services
docker build -t elasticsearch_demo/demo-api:latest -f src/Demo.Api/Dockerfile .
docker build -t elasticsearch_demo/gateway:latest -f src/Gateway/Dockerfile .

# Load images to cluster
kind load docker-image elasticsearch_demo/demo-api:latest --name elasticsearch-demo
kind load docker-image elasticsearch_demo/gateway:latest --name elasticsearch-demo

# Install ElasticSearch custom resource definitions and the operator with its RBAC rules:
kubectl create -f https://download.elastic.co/downloads/eck/2.1.0/crds.yaml
kubectl apply -f https://download.elastic.co/downloads/eck/2.1.0/operator.yaml

# Deploy services
kubectl apply -k kubernetes/environments/kind
```

## Destroy
```bash
kind delete cluster --name elasticsearch-demo
docker rmi elasticsearch_demo/demo-api:latest
docker rmi elasticsearch_demo/gateway:latest
```

## Test 
```bash
# Port forward gateway
kubectl port-forward services/gateway 8000:8000 8001:8001 -n default

# Do api health chech
curl https://localhost:8000/api/health
```

## Connect to ElasticSearch or Kibana
```bash
# Port forward gateway
kubectl port-forward services/gateway 8000:8000 8001:8001 -n default

# Get credentials
PASSWORD=$(kubectl get secret elasticsearch-es-elastic-user -o go-template='{{.data.elastic | base64decode}}')

# Request the Elasticsearch endpoint.
curl -u "elastic:$PASSWORD" -k "https://localhost:8000/elasticsearch"

# Show password for Kibana login
echo $PASSWORD

# Open https://localhost:8000/kibana in your browser. Login with as "elastic" and password above
```

## Connect to Kibana
```bash

```

## Tips and Trics
Check Elastic Search CustomResourceDefinition spesification
```bash
kubectl describe crd elasticsearch
```