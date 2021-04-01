#!/bin/sh
sed -i "s/VERSION/${TRAVIS_BUILD_NUMBER}/g" k8sversion/flask-deployment.yaml
#cat k8sversion/flask-deployment.yaml