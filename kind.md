# Kind Setup
https://kind.sigs.k8s.io/docs/user/quick-start/
https://istio.io/latest/docs/setup/platform-setup/kind/#setup-dashboard-ui-for-kind


```
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.10.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
```


kubectl cluster-info --context kind-kind


export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].port}')
export INGRESS_HOST=$(k get po -l istio=ingressgateway -n istio-system -o jsonpath='{.items[0].status.hostIP}')
# export INGRESS_HOST=$(k -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.clusterIP}')
export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
echo "http://$GATEWAY_URL/productpage"



https://github.com/helm/helm/releases
chmod +x ./helm
sudo mv ./helm /usr/local/bin/helm


kind create cluster --name istio-operator
kubectl cluster-info --context kind-istio-operator


https://kind.sigs.k8s.io/docs/user/local-registry/
docker tag graphql localhost:5000/graphql:1.0
docker push localhost:5000/graphql:1.0


istioctl operator init
kubectl create ns istio-system


Install LB?

https://operatorhub.io/operator/grafana-operator