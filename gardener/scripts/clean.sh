#!/usr/bin/env bash

# shellcheck source=gardener/scripts/common.sh
source "$(dirname "$0")"/common.sh

helm del --purge gardener-controlplane
helm del --purge gardenlet

kubectl delete -f "${KUBEVIRT_DEPLOY_PATH}"/20-crd-cluster.yaml
kubectl delete -f "${KUBEVIRT_DEPLOY_PATH}"/20-crd-infrastructure.yaml
kubectl delete -f "${KUBEVIRT_DEPLOY_PATH}"/20-crd-managedresource.yaml
kubectl delete -f "${KUBEVIRT_DEPLOY_PATH}"/20-crd-operatingsystemconfig.yaml
kubectl delete -f "${KUBEVIRT_DEPLOY_PATH}"/controller-registration.yaml

kubectl delete -f "${BASE_PATH}"/../manifests/extension/ --recursive
