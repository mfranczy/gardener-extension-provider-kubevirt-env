#!/usr/bin/env bash

set -euxo pipefail

# shellcheck source=gardener/scripts/common.sh
source "$(dirname "$0")"/common.sh

# TODO: if there is no gardener repo then clone
# TODO: freeze gardener version to have stable environment

# deploy gardener and gardenlet
helm install "${GARDENER_PATH}"/charts/gardener/controlplane \
  --namespace garden \
  --name gardener-controlplane \
  -f "${BASE_PATH}"/../charts/gardener-values.yaml --wait

helm install "${GARDENER_PATH}"/charts/gardener/gardenlet \
 --namespace garden \
 --name gardenlet \
  -f "${BASE_PATH}"/../charts/gardenlet-values.yaml --wait
