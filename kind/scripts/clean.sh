#!/usr/bin/env bash

# shellcheck source=kind/scripts/common.sh
source "$(dirname "$0")"/common.sh

kind delete cluster --name "${SEED_CLUSTER_NAME}"
kind delete cluster --name "${SHOOT_CLUSTER_NAME}"

rm -rf "${KUBECONFIG_PATH}"
