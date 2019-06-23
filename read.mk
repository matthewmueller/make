# Read will prompt the user for input if the variable
# is not already set
read.%: TEMP := $(or ${TMPDIR},${TMP},${TEMP},/tmp)
read.%:
	@ mkdir -p ${TEMP}/make
	@ while [ "$${input:-${${*}}}" = "" ]; do \
			printf "Enter a value for ${*}: "; \
			read input; \
		done; \
		printf "$${input:-${${*}}}" > ${TEMP}/make/${*}
	@ $(eval export ${*}=`cat ${TEMP}/make/${*}`)
.PHONY: read read. read.%
