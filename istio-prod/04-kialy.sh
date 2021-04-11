#!/bin/bash

kubectl create ns kiali-operator

helm install \
    --set cr.create=true \
    --set cr.namespace=istio-system \
    --namespace kiali-operator \
    --repo https://kiali.org/helm-charts \
    --version 1.29.1 \
    kiali-operator \
    kiali-operator

kubectl apply -f observability/kiali.yaml

### kubectl -n istio-system port-forward deploy/kiali 20001

kubectl create serviceaccount kiali-dashboard -n istio-system
kubectl create clusterrolebinding kiali-dashboard-admin --clusterrole=cluster-admin --serviceaccount=istio-system:kiali-dashboard
kubectl get secret -n istio-system -o jsonpath="{.data.token}" $(kubectl get secret -n istio-system | grep kiali-dashboard | awk '{print $1}' ) | base64 --decode

kubectl get secret -n prometheus prometheus-prom-kube-prometheus-stack-prometheus -o jsonpath="{.data['prometheus\.yaml\.gz']}" | base64 -d | gunzip

