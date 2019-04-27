# update the includes commands locally
install:
	@mkdir -p /usr/local/include/github.com/matthewmueller/make
	@cp *.mk /usr/local/include/github.com/matthewmueller/make/
	@cp -R config /usr/local/include/github.com/matthewmueller/make/
