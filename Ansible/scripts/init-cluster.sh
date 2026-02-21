#!/bin/bash

git clone git@github.com:NachmanM/k8s-project.git /k8s-project


kubectl create secret docker-registry regcred \
--docker-server=992382545251.dkr.ecr.us-east-1.amazonaws.com \
--docker-username=AWS \
--docker-password=$(aws ecr get-login-password --region us-east-1) \
--namespace=default


helm repo add aws-ebs-csi-driver https://kubernetes-sigs.github.io/aws-ebs-csi-driver
helm repo update

helm upgrade --install aws-ebs-csi-driver \
  aws-ebs-csi-driver \
  --repo https://kubernetes-sigs.github.io/aws-ebs-csi-driver \
  --namespace kube-system \
  --version 2.55.1

  kubectl apply -R -f /k8s-project/k8s/