include make

# update the includes commands locally
install:
	@mkdir -p /usr/local/include/github.com/matthewmueller/make
	@cp *.mk /usr/local/include/github.com/matthewmueller/make/
	@cp -R aws /usr/local/include/github.com/matthewmueller/make
	@cp -R config /usr/local/include/github.com/matthewmueller/make

MAKE_FILES := $(shell find . -type f -name '*.mk' ! -path "./example/*" ! -path "./test/*" )

release:
	@ echo $(MAKE_FILES)
.PHONY: release