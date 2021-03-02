# Kind Setup
https://kind.sigs.k8s.io/docs/user/quick-start/


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



kind create cluster --name istio-operator
kubectl cluster-info --context kind-istio-operator