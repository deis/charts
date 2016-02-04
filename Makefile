.PHONY: init
init:
	@echo "Downloading necessary items to run tests..."
	@_scripts/tests/init.sh

.PHONY: create
create:
	@echo "Creating kubernetes cluster + deploying Deis..."
	@_scripts/tests/create.sh

.PHONY: install
install:
	@echo "Installing Deis..."
	@_scripts/tests/install.sh

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

.PHONY: uninstall
uninstall:
	@echo "Uninstalling Deis..."
	@_scripts/tests/uninstall.sh

.PHONY: ci
ci: init create install check test
