.PHONY: init
init:
	@echo "Downloading necessary items to run tests..."
	@_scripts/tests/init.sh

.PHONY: create
create:
	@echo "Creating kubernetes cluster + deploying Deis..."
	@_scripts/tests/create.sh

.PHONY: destroy
destroy:
	@echo "Tearing down kubernetes cluster..."
	@_scripts/tests/destroy.sh

.PHONY: check
check:
	@echo "Ensuring Deis cluster is up..."
	@_scripts/tests/check.sh

.PHONY: test
test:
	@echo "Running e2e tests..."
	@_scripts/tests/test.sh

.PHONY: ci
ci: init create check test
