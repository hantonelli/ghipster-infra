#!/bin/bash

kubectl create ns prometheus
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prom prometheus-community/kube-prometheus-stack --version 13.13.1 -n prometheus -f labs/03/prom-values.yaml
### kubectl -n prometheus port-forward statefulset/prometheus-prom-kube-prometheus-stack-prometheus 9090
### kubectl -n prometheus port-forward svc/prom-grafana 3000:80

kubectl -n prometheus create cm istio-dashboards \
--from-file=pilot-dashboard.json=observability/dashboards/pilot-dashboard.json \
--from-file=istio-workload-dashboard.json=observability/dashboards/istio-workload-dashboard.json \
--from-file=istio-service-dashboard.json=observability/dashboards/istio-service-dashboard.json \
--from-file=istio-performance-dashboard.json=observability/dashboards/istio-performance-dashboard.json \
--from-file=istio-mesh-dashboard.json=observability/dashboards/istio-mesh-dashboard.json \
--from-file=istio-extension-dashboard.json=observability/dashboards/istio-extension-dashboard.json

kubectl label -n prometheus cm istio-dashboards grafana_dashboard=1

### kubectl -n prometheus port-forward svc/prom-grafana 3000:80

kubectl apply -f observability/monitor-control-plane.yaml

kubectl apply -f observability/monitor-data-plane.yaml
