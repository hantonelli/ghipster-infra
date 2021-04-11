#!/bin/bash

istioctl install -y -n istio-system -f ingress-gateway/ingress-gateways.yaml --revision 1-8-3
GATEWAY_IP=$(kubectl get svc -n istio-system istio-ingressgateway -o jsonpath="{.status.loadBalancer.ingress[0].ip}")

kubectl create -n istio-system secret tls istioinaction-cert --key labs/04/certs/istioinaction.io.key --cert ingress-gateway/certs/istioinaction.io.crt


kubectl create namespace cert-manager
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install cert-manager jetstack/cert-manager --namespace cert-manager --version v1.2.0 --create-namespace --set installCRDs=true
kubectl create -n cert-manager secret tls cert-manager-cacerts --cert ingress-gateway/certs/ca/root-ca.crt --key ingress-gateway/certs/ca/root-ca.key
kubectl apply -f ingress-gateway/cert-manager/ca-cluster-issuer.yaml
kubectl apply -f ingress-gateway/cert-manager/istioinaction-io-cert.yaml 

istioctl install -y -n istio-system -f ingress-gateway/control-plane-reduce-gw-config.yaml --revision 1-8-3

kubectl apply -f ingress-gateway/ingress-gw-access-logging.yaml
GATEWAY_IP=$(kubectl get svc -n istio-system istio-ingressgateway -o jsonpath="{.status.loadBalancer.ingress[0].ip}")