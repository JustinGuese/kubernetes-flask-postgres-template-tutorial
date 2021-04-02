#!/bin/bash
# kubectl create secret generic pgpassword --from-literal='PGPASSWORD=''
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.44.0/deploy/static/provider/aws/deploy.yaml
kubectl apply -f k8sversion