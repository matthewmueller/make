# Default to the help command
.DEFAULT_GOAL := help

# Constants
ROOT    := $(realpath $(join $(dir $(lastword $(MAKEFILE_LIST))), ..))
TEMP    := $(or ${TMPDIR},${TMP},${TEMP},/tmp)/make
CONFIG  := $(ROOT)/config
CACHE   := $(ROOT)/cache
APP     := ${PWD}
STD     := 1

help.%:
	@ echo "HELLO! $(*)"

# Create a temporary directory, if we haven't already
$(TEMP):
	@ mkdir -p $(TEMP)

# Create a cache directory, if we haven't already
$(CACHE):
	@ mkdir -p $(CACHE)

# Create a config directory, if we haven't already
$(CONFIG):
	@ mkdir -p $(CONFIG)

# Displays this help message
help: dep.awk
	@echo ""
	@echo "\033[1mUsage\033[0m"
	@echo ""
	@echo "  $$ make [command]..."
	@awk -f $(CONFIG)/std/help.awk $(MAKEFILE_LIST)
	@echo ""
.PHONY: help

# Ensure we have the provided environment variable
env.%:
	@ if [ "${${*}}" = "" ]; then \
		echo "\n  Error: You must set the \`${*}\` variable.\n"; \
		exit 1; \
	fi
.PHONY: env env. env.%

# Ensure we have the provided environment variable
# uenv ensures that the input is all uppercase
uenv.%:
	@ if [ "${$$(echo '${*}' | tr a-z A-Z)}" = "" ]; then \
		echo "\n  Error: You must pass in the \`$$(echo '${*}' | tr a-z A-Z)\` environment variable.\n"; \
		exit 1; \
	fi
.PHONY: uenv uenv. uenv.%

# Ensure we have the provided command dependency in our $PATH
dep.%:
	@ if [ "$$(command -v ${*})" = "" ]; then \
		echo "\n  Error: Required dependency \`$*\` is not found in your PATH.\n"; \
		exit 1; \
	fi
.PHONY: dep dep. dep.%

gomod.%:

# TODO: node_module utility like dep.%
# node_module.%:
# .PHONY: node_module node_module. node_module.%

# Always prompt the user, but if the variable is in scope,
# use that value as the default. Use $$(cat $(TEMP)/___)
# to read the result, where ___ is the name of the variable
prompt.%: $(TEMP)
	@ if [ "${${*}}" = "" ]; then \
			while [ "$${input}" = "" ]; do \
				echo "Enter a value for ${*}: \c"; \
				read input; \
			done; \
		else \
			echo "Enter a value for ${*} (default: ${${*}}): \c"; \
			read input; \
		fi; \
		echo "$${input:-${${*}}}" > ${TEMP}/${*}
.PHONY: prompt prompt. prompt.%

# First try reading from an environment variable.
# If the env is empty, prompt the user for a value
# Use $$(cat $(TEMP)/___) to read the result, where
# ___ is the name of the variable
eprompt.%: $(TEMP)
	@ while [ "$${input:-${${*}}}" = "" ]; do \
			echo "Enter a value for ${*}: \c"; \
			read input; \
		done; \
		echo "$${input:-${${*}}}" > ${TEMP}/${*}
.PHONY: eprompt eprompt. eprompt.%

get.%:
	@ echo ${*}