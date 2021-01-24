# Install MicroK8S
microk8s.reset
snap remove microk8s
rm ~/.kube/config

sudo snap install microk8s --classic --channel=1.19
microk8s enable ingress jaeger metrics-server prometheus registry storage dashboard dns helm helm3 istio

cd $HOME && mkdir .kube && cd .kube && microk8s config > config

k get all --all-namespaces


If RBAC is not enabled access the dashboard using the default token retrieved with:
```
token=$(microk8s kubectl -n kube-system get secret | grep default-token | cut -d " " -f1)
microk8s kubectl -n kube-system describe secret $token
```

In an RBAC enabled setup (microk8s enable RBAC) you need to create a user with restricted permissions as shown in:
https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md


# Add kubectl autocomplete
https://kubernetes.io/docs/reference/kubectl/cheatsheet/
