# Deploy to local docker

## Deploy
```bash
docker-compose -f deploy/docker-compose/docker-compose.yml --project-name es_demo up -d
```

## Destroy
```bash
docker-compose -f deploy/docker-compose/docker-compose.yml --project-name es_demo down 

# Remove images
docker rmi elasticsearch_demo/demo-api:latest
docker rmi elasticsearch_demo/gateway:latest
```

## Set certificates
```bash
set -a;
source deploy/docker-compose/.env
set +a

# Create development certificate
dotnet dev-certs https -ep .crt/Demo.Api.pfx -p $DEMO_API_CERT_PASSWORD

# Create Envoy gateway https cert with passphrase "p4ssw0rd" (same as envoy config file)
openssl req -x509 -newkey rsa:4096 -keyout .crt/key.pem -out .crt/https.crt -days 365
```

## Set ElasticSearch certificate
```bash
# Locate the CA certificate in your container.
path=$(printf $(docker exec -it ElasticSearch /bin/bash -c "find /usr/share/elasticsearch -name http_ca.crt") | tr -d '\r')

# Copy the http_ca.crt security certificate from your Docker container to your local machine.
docker cp ElasticSearch:$path .crt
```

## Test 

```bash
# Get environment variables
set -a;
source deploy/docker-compose/.env
set +a

# Test ElasticSearch via gateway
curl -k --cacert .crt/http_ca.crt -u "elastic:$ELASTIC_PASSWORD" https://localhost:8000/elasticsearch?pretty

# Test Kibana via gateway
curl -k --cacert .crt/http_ca.crt -u "elastic:$ELASTIC_PASSWORD" https://localhost:8000/kibana

# Test demo api via gateway
curl -k https://localhost:8000/api/health
```