## Ensure we have the provided environment variable
env.%:
	@ if [ ${${*}} = "" ]; then \
		echo "Required variable \`${*}\` is not set."; \
		exit 1; \
	fi
.PHONY: env env. env.%