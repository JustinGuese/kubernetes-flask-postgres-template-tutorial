#!/bin/bash
# curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
minikube addons enable ingress
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx
# deploy
kubectl apply -f ./k8sversion