#!/bin/bash
# kubectl create secret generic pgpassword --from-literal='PGPASSWORD=''
helm repo add nginx-stable https://helm.nginx.com/stable
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install nginx-ing nginx-stable/nginx-ingress --set rbac.create=true
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.44.0/deploy/static/provider/aws/deploy.yaml
kubectl create namespace cert-manager
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v1.2.0 \
  --create-namespace
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.2.0/cert-manager.yaml
kubectl apply -f k8sversion