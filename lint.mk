DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

# Dependencies
ESLINT_CONFIG := $(addprefix eslint-config-, airbnb prettier)
ESLINT_PLUGINS := $(addprefix eslint-plugin-, import react jsx-a11y prettier)
ESLINT_DEPENDENCIES := $(ESLINT_CONFIG) $(ESLINT_PLUGINS)
ESLINT_NODE_MODULES := $(addprefix node_modules/, eslint prettier $(ESLINT_DEPENDENCIES))

# Add the gitignore to the ignore path if we have one
ifneq ("$(wildcard ./.gitignore)","")
    ESLINT_IGNORE_PATH = --ignore-path .gitignore
endif

# Lint our project (use this as pre-commit)
lint: .eslintrc $(ESLINT_NODE_MODULES)
	@./node_modules/.bin/eslint $(ESLINT_IGNORE_PATH) **/*.js

# Fix and lint our project
lint.fix: .eslintrc $(ESLINT_NODE_MODULES)
	@./node_modules/.bin/eslint $(ESLINT_IGNORE_PATH) --fix **/*.js

# Lint our project and watch for changes
lint.watch: .eslintrc $(ESLINT_NODE_MODULES) node_modules/eslint-watch
	@./node_modules/.bin/esw $(ESLINT_IGNORE_PATH) -w --clear --fix **/*.js

# Copy our eslint config into the project
.eslintrc:
	@cp "$(DIR)/config/.eslintrc" "./.eslintrc"

# Download all eslint dependencies
$(ESLINT_NODE_MODULES):
	@yarn add -D $(notdir $@)

node_modules/eslint-watch:
	@yarn add -D eslint-watch