config: githooks-install # Configure development environment

githooks-install: # Install git hooks configured in this repository
	echo "./scripts/githooks/pre-commit" > .git/hooks/pre-commit
	chmod +x .git/hooks/pre-commit

update-lib-detect-os: # Update the Detect Operating System libarary from source
	curl -fsLS \
		https://raw.githubusercontent.com/make-ops-tools/detect-operating-system/main/scripts/detect-operating-system.sh \
			> ./private_dot_local/bin/executable_detect-operating-system.sh
	chmod +x ./private_dot_local/bin/executable_detect-operating-system.sh

clean: # Clean development environment
	rm -rf \
		~/.config/chezmoi \
		./assets/iterm2/com.googlecode.* \
		./bin/chezmoi

# ==============================================================================

help: # List Makefile targets
	@awk 'BEGIN {FS = ":.*?# "} /^[ a-zA-Z0-9_-]+:.*? # / {printf "\033[36m%-41s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

list-variables: # List all the variables available to make
	@$(foreach v, $(sort $(.VARIABLES)),
		$(if $(filter-out default automatic, $(origin $v)),
			$(if $(and $(patsubst %_PASSWORD,,$v), $(patsubst %_PASS,,$v), $(patsubst %_KEY,,$v), $(patsubst %_SECRET,,$v)),
				$(info $v=$($v) ($(value $v)) [$(flavor $v),$(origin $v)]),
				$(info $v=****** (******) [$(flavor $v),$(origin $v)])
			)
		)
	)

.DEFAULT_GOAL := help
.EXPORT_ALL_VARIABLES:
.NOTPARALLEL:
.ONESHELL:
.PHONY: *
MAKEFLAGS := --no-print-director
SHELL := /bin/bash
ifeq (true, $(shell [[ "$(VERBOSE)" =~ ^(true|yes|y|on|1|TRUE|YES|Y|ON)$$ ]] && echo true))
	.SHELLFLAGS := -cex
else
	.SHELLFLAGS := -ce
endif

.SILENT: \
	clean \
	config \
	githooks-install \
	update-lib-detect-os
