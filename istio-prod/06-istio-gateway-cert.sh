

helm repo add appscode https://charts.appscode.com/stable/
helm repo update
helm install kubed appscode/kubed --version v0.12.0 --namespace kube-system

kubectl delete -f ./labs/04/cert-manager/istioinaction-io-cert.yaml
kubectl -n istio-system delete secret istioinaction-cert
kubectl rollout restart deploy/istio-ingressgateway -n istio-system

kubectl create -n istioinaction secret tls istioinaction-cert --key labs/04/certs/istioinaction.io.key --cert istio-gateway/certs/istioinaction.io.crt

kubectl label namespace istio-system secrets-sync=true
kubectl -n istioinaction annotate secret istioinaction-cert kubed.appscode.com/sync="secrets-sync=true"
istioctl pc secret deploy/istio-ingressgateway -n istio-system
istioctl install -y -n istioinaction -f ingress-gateway/my-user-gateway.yaml --revision 1-8-3
kubectl create -n istioinaction secret tls my-user-gw-istioinaction-cert --key ingress-gateway/certs/istioinaction.io.key --cert labs/04/certs/istioinaction.io.crt

kubectl apply -f ingress-gateway/my-user-gw-https.yaml
kubectl apply -f ingress-gateway/my-user-gw-vs.yaml

CUSTOM_GATEWAY_IP=$(kubectl get svc -n istioinaction my-user-gateway  -o jsonpath="{.status.loadBalancer.ingress[0].ip}")

# cat ingress-gateway/ingress-gateways-public.yaml
# cat ingress-gateway/ingress-gateways-private.yaml
# cat ingress-gateway/ingress-gateways-nlb-hc.yaml
