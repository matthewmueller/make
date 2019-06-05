# Ensure we have the provided command binary in our $PATH
bin.%:
	@ if [ "$$(command -v ${*})" = "" ]; then \
		echo "Required binary \`${*}\` is not found in your \$$PATH."; \
		exit 1; \
	fi
.PHONY: bin bin. bin.%