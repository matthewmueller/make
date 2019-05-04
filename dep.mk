# Ensure we have the provided command dependency in our $PATH
dep.%:
	@ if [ "$$(command -v ${*})" = "" ]; then \
		echo "\n  Error: Required dependency \`${*}\` is not found in your PATH.\n"; \
		exit 1; \
	fi
.PHONY: dep dep. dep.%