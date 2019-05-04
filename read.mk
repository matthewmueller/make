# Always prompt the user, but if the variable is in scope,
# use that value as the default. Use $$(cat $(TEMP)/___)
# to read the result, where ___ is the name of the variable
.PHONY: read read. read.%
read.%: TEMP := $(or ${TMPDIR},${TMP},${TEMP},/tmp)/make
read.%: $(TEMP)
	@ mkdir -p $(TEMP)
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

# First try reading from an environment variable.
# If the env is empty, prompt the user for a value
# Use $$(cat $(TEMP)/___) to read the result, where
# ___ is the name of the variable
.PHONY: eread eread. eread.%
eread.%: TEMP := $(or ${TMPDIR},${TMP},${TEMP},/tmp)/make
eread.%: $(TEMP)
	@ mkdir -p $(TEMP)
	@ while [ "$${input:-${${*}}}" = "" ]; do \
			echo "Enter a value for ${*}: \c"; \
			read input; \
		done; \
		echo "$${input:-${${*}}}" > ${TEMP}/${*}