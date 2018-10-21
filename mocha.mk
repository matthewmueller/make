# Mocha test file glob (default: "./**/*_test.js")
MOCHA_TEST ?= "./**/*_test.js"

# Grep mocha tests (default: ".*")
MOCHA_GREP ?= ".*"

# Run mocha tests
mocha: node_modules/.bin/mocha node_modules/esm
	@./node_modules/.bin/mocha -r esm -g $(MOCHA_GREP) $(MOCHA_TEST)

# Run mocha tests in watch mode
mocha.watch: node_modules/.bin/mocha node_modules/esm
	@./node_modules/.bin/mocha -r esm -g $(MOCHA_GREP) --watch $(MOCHA_TEST)

# Run mocha tests with code coverage
mocha.cover: node_modules/.bin/nyc node_modules/.bin/mocha node_modules/esm
	@./node_modules/.bin/nyc --reporter=text ./node_modules/.bin/mocha -r esm -g $(MOCHA_GREP) $(MOCHA_TEST)
	@rm -rf ./.nyc_output

# Run mocha tests with detailed code coverage
mocha.cover.html: node_modules/.bin/nyc node_modules/.bin/mocha node_modules/esm
	@./node_modules/.bin/nyc --report-dir $(TMPDIR)/mocha --reporter=lcov ./node_modules/.bin/mocha -r esm -g $(MOCHA_GREP) $(MOCHA_TEST)
	@open $(TMPDIR)/mocha/lcov-report/index.html
	@rm -rf ./.nyc_output

node_modules/.bin/mocha:
	@yarn add -D mocha

node_modules/.bin/nyc:
	@yarn add -D nyc

node_modules/esm:
	@yarn add -D esm
