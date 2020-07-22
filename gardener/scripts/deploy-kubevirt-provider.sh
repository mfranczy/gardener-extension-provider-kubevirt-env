#!/usr/bin/env bash

set -euxo pipefail

# shellcheck source=gardener/scripts/common.sh
source "$(dirname "$0")"/common.sh

kubectl apply -f "${KUBEVIRT_DEPLOY_PATH}"/20-crd-cluster.yaml
kubectl apply -f "${KUBEVIRT_DEPLOY_PATH}"/20-crd-infrastructure.yaml
kubectl apply -f "${KUBEVIRT_DEPLOY_PATH}"/20-crd-managedresource.yaml
kubectl apply -f "${KUBEVIRT_DEPLOY_PATH}"/20-crd-operatingsystemconfig.yaml
kubectl apply -f "${BASE_PATH}"/../manifests/extension/ --recursive
kubectl apply -f "${KUBEVIRT_DEPLOY_PATH}"/controller-registration.yaml

kubeconfig_seed_internal=$(kind get kubeconfig --name "${SEED_CLUSTER_NAME}" --internal | base64 -w0)
kubeconfig_shoot_internal=$(kind get kubeconfig --name "${SHOOT_CLUSTER_NAME}" --internal | base64 -w0)

yq w -d3 "${BASE_PATH}"/../manifests/seed.yaml data.kubeconfig "${kubeconfig_seed_internal}" \
 > "${BASE_PATH}"/../manifests/seed.yaml.render
yq w -d0 "${BASE_PATH}"/../manifests/shoot.yaml data.kubeconfig "${kubeconfig_shoot_internal}" \
 > "${BASE_PATH}"/../manifests/shoot.yaml.render

kubectl apply -f "${BASE_PATH}"/../manifests/seed.yaml.render
kubectl apply -f "${BASE_PATH}"/../manifests/shoot.yaml.render
