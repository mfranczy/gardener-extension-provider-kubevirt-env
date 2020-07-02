#!/usr/bin/env bash

set -euxo pipefail

# shellcheck source=kind/scripts/common.sh
source "$(dirname "$0")"/common.sh

# create gardener/seed cluster
kind create cluster --name "${SEED_CLUSTER_NAME}" --config "${BASE_PATH}"/../manifests/seed-cluster.yaml

# install calico
kubectl apply -f https://docs.projectcalico.org/v3.15/manifests/calico.yaml
# disable Kernel's RPF check
kubectl -n kube-system set env daemonset/calico-node FELIX_IGNORELOOSERPF=true

install_metallb
# apply metallb network config
kubectl apply -f "${BASE_PATH}"/../manifests/seed-lb.yaml

# TODO: check helm version and switch to helm3
helm init
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule \
--clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl patch deploy --namespace kube-system tiller-deploy -p \
'{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'

export_kubeconfig "${SEED_CLUSTER_NAME}"
