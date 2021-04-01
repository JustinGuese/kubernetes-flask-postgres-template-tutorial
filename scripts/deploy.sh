#!/bin/bash
echo "$KUBERNETES_CLUSTER_CERTIFICATE" > cert.crt
# check install for debug
/usr/local/bin/kubectl cluster-info
# install nginx ingress for aws
/usr/local/bin/kubectl \
  --kubeconfig=/dev/null \
  --server=$KUBERNETES_SERVER \
  --certificate-authority=cert.crt \
  --token=$KUBERNETES_TOKEN \
  apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.44.0/deploy/static/provider/aws/deploy.yaml
# helm should be installed now 
# setup namespace for cert manager
/usr/local/bin/kubectl create namespace cert-manager
# add cert manager repo
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v1.2.0 \
  --create-namespace
/usr/local/bin/kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.2.0/cert-manager.crds.yaml
# now start real build
/usr/local/bin/kubectl \
  --kubeconfig=/dev/null \
  --server=$KUBERNETES_SERVER \
  --certificate-authority=cert.crt \
  --token=$KUBERNETES_TOKEN \
  apply -f ./k8sversion/
echo "The build number is ${TRAVIS_BUILD_NUMBER}"
/usr/local/bin/kubectl \
  --kubeconfig=/dev/null \
  --server=$KUBERNETES_SERVER \
  --certificate-authority=cert.crt \
  --token=$KUBERNETES_TOKEN \
  set image deployment/carflask carflask=guestros/carflask:${TRAVIS_BUILD_NUMBER} --record