FROM envoyproxy/envoy:v1.20.2
COPY "src/Gateway/envoy.yml" "/etc/envoy/envoy.yaml"
ADD .crt/https.crt /etc/ssl/certs/https.crt
ADD .crt/key.pem /etc/ssl/certs/key.pem
