#!/bin/bash

kubectl create ns istio-system
kubectl apply -f istio/istiod-service.yaml
istioctl install -y -n istio-system -f istio/control-plane.yaml --revision 1-8-3
