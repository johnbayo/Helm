#!/bin/sh
echo "creating namespace"
./bin/kubectl --kubeconfig=k8s/config create namespace hello-world
sleep 5s
echo "deploying chart"
./bin/helm install --namespace hello-world --kubeconfig k8s/config httpservice