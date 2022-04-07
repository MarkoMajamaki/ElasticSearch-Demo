# Deploy to docker using CLI only

Start Elasticsearch in Docker. Copy the generated password and enrollment token and save them in a secure location. 
```bash
docker run --name elasticsearch -p 9200:9200 -it docker.elastic.co/elasticsearch/elasticsearch:8.1.0
```

Locate the CA certificate in your container.
```bash
docker exec -it elasticsearch /bin/bash -c "find /usr/share/elasticsearch -name http_ca.crt"
```

Copy the http_ca.crt security certificate from your Docker container to your local machine.
```bash
mkdir .crt
docker cp elasticsearch:/usr/share/elasticsearch/config/certs/http_ca.crt .crt
```

Test connection with cert
```bash
curl --cacert .crt/http_ca.crt -u elastic https://localhost:9200
```