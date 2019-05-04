# Always prompt the user, but if the variable is in scope,
# use that value as the default. Use $$(cat $(TEMP)/___)
# to read the result, where ___ is the name of the variable
read.%: TEMP := $(or ${TMPDIR},${TMP},${TEMP})
read.%:
	@ if [ "${TEMP}" = "" ]; then \
		echo "Required temporary directory not found"; \
		exit 1; \
	fi
	@ mkdir -p ${TEMP}/make
	@ if [ "${${*}}" = "" ]; then \
			while [ "$${input}" = "" ]; do \
				echo "Enter a value for ${*}: \c"; \
				read input; \
			done; \
		else \
			echo "Enter a value for ${*} (default: ${${*}}): \c"; \
			read input; \
		fi; \
		echo "$${input:-${${*}}}" > ${TEMP}/make/${*}
.PHONY: read read. read.%

# First try reading from an environment variable.
# If the env is empty, prompt the user for a value
# Use $$(cat $(TEMP)/___) to read the result, where
# ___ is the name of the variable
eread.%: TEMP := $(or ${TMPDIR},${TMP},${TEMP})
eread.%:
	@ if [ "${TEMP}" = "" ]; then \
		echo "Required temporary directory not found"; \
		exit 1; \
	fi
	@ mkdir -p ${TEMP}/make
	@ while [ "$${input:-${${*}}}" = "" ]; do \
			echo "Enter a value for ${*}: \c"; \
			read input; \
		done; \
		echo "$${input:-${${*}}}" > ${TEMP}/make/${*}
.PHONY: eread eread. eread.%