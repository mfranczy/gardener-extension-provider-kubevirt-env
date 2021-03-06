# Gardener KubeVirt extensions environment
Simple clusters setup for kubevirt-extension development purposes.

The setup creates the following clusters:
* gardener-seed - contains gardener control plane and gardenlet
* shoot - contains installed KubeVirt 

*NOTE: kubeconfig(s) can be found under the `kubeconfig` directory*

## Prerequisites
The following binaries are required to run the development environment
- [helm3](https://helm.sh/docs/intro/install/)
- [yq](https://github.com/mikefarah/yq#install)
- [kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)

*NOTE: KVM kernel modules must be loaded on the host to run VMs*

Before clusters bring up, check the Kind network subnets and adjust the MetalLB config accordingly

run
`docker network inspect kind`

*NOTE: if the "kind" network does not exist, then find which one is being used by Kind*

adjust MetalLB subnets under
* `kind/manifests/seed-lb.yaml`
* `kind/manifests/shoot-lb.yaml`

*NOTE: both clusters should have different subnets for the LoadBalancer service*

Install the gardener repository and checkout the v1.7.2 tag
`go get github.com/gardener/gardener/... && cd $GOPATH/src/gardener/gardener && git checkout v1.7.2`

## Run the environment

### Bring up clusters
`make cluster-up`

### Deploy gardener and gardenlet
The command installs gardener extensions as well, including KubeVirt extension.

`make deploy`

### Shutdown clusters:
`make clean`
