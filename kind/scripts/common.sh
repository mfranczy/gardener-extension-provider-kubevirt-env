#!/usr/bin/env bash

BASE_PATH=$(dirname "$0")
KUBECONFIG_PATH=$BASE_PATH/../../kubeconfig

SEED_CLUSTER_NAME=gardener-seed
SHOOT_CLUSTER_NAME=shoot

function install_metallb {
  kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
  kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
  kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
}

function export_kubeconfig {
  kind export kubeconfig --name "$1" --kubeconfig "${KUBECONFIG_PATH}/$1"
}
