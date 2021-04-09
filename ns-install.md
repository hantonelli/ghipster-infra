# Create Kind Cluster
kind create cluster --name kind-simple --config ./kind/local-registry.yaml

# Create LB - https://kind.sigs.k8s.io/docs/user/loadbalancer/
k apply -f https://raw.githubusercontent.com/metallb/metallb/master/manifests/namespace.yaml
k create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" 
k apply -f https://raw.githubusercontent.com/metallb/metallb/master/manifests/metallb.yaml
// CHECK IP RANGE AND AJUST ./istio/metal-config.yaml ACCORDINLY
docker network inspect -f '{{.IPAM.Config}}' kind
k apply -f ./istio/metal-config.yaml


# Init Istio
istioctl operator init
k create namespace istio-system
k apply -f ./istio/init_base.yaml
k apply -f ../istio/samples/addons

# NS
k create ns mutual
k label namespace mutual istio-injection=enabled
k apply -f ./istio/mts.yaml
k apply -f ./istio/base.yaml --namespace=mutual

# GW
export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
echo "$GATEWAY_URL"


# DON'T do this Increate Max virtual memory areas
https://github.com/docker-library/elasticsearch/issues/111#issuecomment-268989731
sudo gedit /etc/sysctl.conf # vm.max_map_count=262144
sudo sysctl -w vm.max_map_count=262144

k create namespace monitoring
k label namespace monitoring istio-injection=enabled
k apply -f https://download.elastic.co/downloads/eck/1.4.1/all-in-one.yaml
k apply -f ./elk/elastic.yaml --namespace=monitoring

k --namespace=monitoring port-forward service/kibana-kb-http 5601


https://localhost:5601
user: Elastic
pass: 
k --namespace=monitoring get secret elasticsearch-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode; echo


k apply -f ./elk/elastic_old.yaml --namespace=monitoring
k apply -f ./elk/filebeat.yaml --namespace=monitoring