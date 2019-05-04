# Ensure we have the provided command dependency in our $PATH
dep.%:
	@ if [ "$$(command -v ${*})" = "" ]; then \
		echo "Required dependency \`${*}\` is not found in your \$$PATH."; \
		exit 1; \
	fi
.PHONY: dep dep. dep.%