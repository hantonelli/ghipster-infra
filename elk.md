# Main Blog
https://medium.com/swlh/setting-up-elasticsearch-and-kibana-on-google-kubernetes-engine-with-eck-6823b9842140


USE THIS SITE
https://www.elastic.co/guide/en/cloud-on-k8s/1.4/k8s-deploy-elasticsearch.html

kubectl apply -f https://download.elastic.co/downloads/eck/1.4.0/all-in-one.yaml


ELASTIC_PASSWORD=$(kubectl get secret quickstart-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode)
k get secret elasticsearch-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode; echo


For development envoronments and local development, we will use the Elastic operator

https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s-deploy-eck.html


https://github.com/elastic/helm-charts/tree/master/elasticsearch
helm install elasticsearch elastic/elasticsearch

https://github.com/elastic/helm-charts/tree/master/kibana
helm install kibana elastic/kibana



https://github.com/ubuntu/microk8s/issues/500
systemctl stop --user gvfs-udisks2-volume-monitor