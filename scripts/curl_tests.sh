echo "Docker compose tests"

# Get environment variables
set -a;
source deploy/docker-compose/.env
set +a

# Save path
path=https://localhost:9200
path=http://ent-adent-nuntest-elasticsearch.westeurope.cloudapp.azure.com:9200

curl $path

# Test connection
curl --cacert .crt/http_ca.crt -u "elastic:$ELASTIC_PASSWORD" $path

# create index
curl -X PUT \
--cacert .crt/http_ca.crt \
-u "elastic:$ELASTIC_PASSWORD" \
"$path/my-index?pretty"

# Simple query
curl -X GET "$path/my-index/_search?pretty" \
--cacert .crt/http_ca.crt \
-u "elastic:$ELASTIC_PASSWORD" 

# Get all indexes
curl $path/_aliases \
--cacert .crt/http_ca.crt \
-u "elastic:$ELASTIC_PASSWORD"

