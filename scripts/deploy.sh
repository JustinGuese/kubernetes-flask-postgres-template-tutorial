#!/bin/bash
echo "$KUBERNETES_CLUSTER_CERTIFICATE" | base64 --decode > cert.crt
# install nginx ingress for aws
/usr/local/bin/kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.44.0/deploy/static/provider/aws/deploy.yaml
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
  set image deployment/carflask pypytest=guestros/carflask:${TRAVIS_BUILD_NUMBER} --record