.PHONY: cluster-up
cluster-up:
	kind/scripts/up_shoot.sh
	kind/scripts/up_gardener_seed.sh

.PHONY: clean
clean:
	kind/scripts/clean.sh

.PHONY: deploy-gardener
deploy-gardener:
	gardener/scripts/deploy-gardener.sh

.PHONY: deploy-kubevirt-provider
deploy-kubevirt-provider:
	gardener/scripts/deploy-kubevirt-provider.sh

.PHONY: deploy
deploy: deploy-gardener deploy-kubevirt-provider

.PHONY: gardener-clean
gardener-clean:
	gardener/scripts/clean.sh
