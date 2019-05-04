## Ensure we have the provided environment variable
env.%:
	@ if [ "${${*}}" = "" ]; then \
		echo "Required variable \`${*}\` is not set."; \
		exit 1; \
	fi
.PHONY: env env. env.%

## Ensure we have the provided environment variable
## ucenv ensures that the input is all uppercase
ucenv.%:
	@ if [ "$$(command -v tr)" = "" ]; then \
		echo "\n  Error: Required dependency \`tr\` is not found in your PATH.\n"; \
		exit 1; \
	fi
	@ if [ "${$$(echo '${*}' | tr a-z A-Z)}" = "" ]; then \
		echo "\n  Error: You must pass in the \`$$(echo '${*}' | tr a-z A-Z)\` environment variable.\n"; \
		exit 1; \
	fi
.PHONY: uenv uenv. uenv.%
