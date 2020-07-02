#!/usr/bin/env bash

BASE_PATH=$(dirname "$0")
GARDENER_PROJECT_PATH=$GOPATH/src/github.com/gardener
GARDENER_PATH=$GARDENER_PROJECT_PATH/gardener
KUBEVIRT_DEPLOY_PATH=$GARDENER_PROJECT_PATH/gardener-extension-provider-kubevirt/example

# TODO: set this in one place - shared between gardener and kind scripts
SEED_CLUSTER_NAME=gardener-seed
SHOOT_CLUSTER_NAME=shoot
