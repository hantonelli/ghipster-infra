
kubectl apply -f mtls/default-peerauth-permissive.yaml
kubectl apply -f mtls/purchase-history-strict.yaml
kubectl apply -f mtls/audit-auth-policy.yaml
kubectl apply -f mtls/web-api-access-logging-audit.yaml
kubectl apply -f mtls/istioinaction-peerauth-strict.yaml