.DEFAULT_GOAL := help

## Displays this help message
help: ROOT := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
help: CONFIG := $(ROOT)/config
help:
	@ if [ "$$(command -v awk)" = "" ]; then \
		echo "\n  Error: Required dependency \`awk\` is not found in your PATH.\n"; \
		exit 1; \
	fi
	@ echo ""
	@ echo "\033[1mUsage\033[0m"
	@ echo ""
	@ echo "  $$ make [command]..."
	@ awk -f $(CONFIG)/help.awk $(MAKEFILE_LIST)
	@ echo ""
.PHONY: help
