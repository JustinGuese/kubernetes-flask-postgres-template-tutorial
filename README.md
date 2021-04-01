[![Build Status](https://travis-ci.com/JustinGuese/kubernetes-flask-postgres-template-tutorial.svg?branch=master)](https://travis-ci.com/JustinGuese/kubernetes-flask-postgres-template-tutorial)

# travis tut

https://medium.com/@drew.buckman/use-travis-ci-to-automate-the-deployment-of-a-python-gunicorn-app-to-kubernetes-2a42cb9d2e88

- getting a kubernetes token

aws eks get-token --region eu-central-1 --cluster-name testcluster

# aws eks create cluster

https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html


aws ec2 create-key-pair --region eu-central-1 --key-name keyname
eksctl create cluster \
--name bwtest \
--region eu-central-1 \
--with-oidc \
--spot \
--instance-types=t3a.micro \
--version=1.19 \
--nodes-min=1 \
--nodes-max=3 \
--ssh-access \
--ssh-public-key keyname \
--managed


### deleting it

eksctl delete cluster --name bwtest --region eu-central-1
