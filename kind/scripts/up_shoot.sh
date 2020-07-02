#!/usr/bin/env bash

set -euxo pipefail

# shellcheck source=kind/scripts/common.sh
source "$(dirname "$0")"/common.sh

KUBEVIRT_VERSION="v0.29.0"
CDI_VERSION="v1.18.0"

# create shoot cluster
kind create cluster --name "${SHOOT_CLUSTER_NAME}" --config "${BASE_PATH}"/../manifests/shoot-cluster.yaml

install_metallb
# apply metallb network config
kubectl apply -f "${BASE_PATH}"/../manifests/shoot-lb.yaml

# install kubevirt and CDI
kubectl apply -f https://github.com/kubevirt/containerized-data-importer/releases/download/"${CDI_VERSION}"/cdi-operator.yaml
kubectl apply -f https://github.com/kubevirt/containerized-data-importer/releases/download/"${CDI_VERSION}"/cdi-cr.yaml

kubectl create -f https://github.com/kubevirt/kubevirt/releases/download/"${KUBEVIRT_VERSION}"/kubevirt-operator.yaml
kubectl create -f https://github.com/kubevirt/kubevirt/releases/download/"${KUBEVIRT_VERSION}"/kubevirt-cr.yaml

cat <<EOF | kubectl create -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: kubevirt-config
  namespace: kubevirt
  labels:
    kubevirt.io: ""
data:
  feature-gates: "DataVolumes"
EOF

export_kubeconfig "${SHOOT_CLUSTER_NAME}"
