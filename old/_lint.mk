DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

# What to lint (default: "./")
LINT_GLOB ?= "./"

# Dependencies
ESLINT_CONFIG := $(addprefix eslint-config-, airbnb prettier)
ESLINT_PLUGINS := $(addprefix eslint-plugin-, import react jsx-a11y prettier)
ESLINT_DEPENDENCIES := eslint prettier $(ESLINT_CONFIG) $(ESLINT_PLUGINS)
ESLINT_NODE_MODULES := $(addprefix node_modules/, $(ESLINT_DEPENDENCIES))

# Add the gitignore to the ignore path if we have one
ifneq ("$(wildcard ./.gitignore)","")
	ESLINT_IGNORE_PATH = --ignore-path ./.gitignore
endif

ifneq ("$(wildcard ./.eslintrc)","")
	LINT_PATH = .eslintrc
else
	LINT_PATH = $(DIR)/config/.eslintrc
endif

# Lint our project (use this as pre-commit)
lint: $(ESLINT_NODE_MODULES)
	@./node_modules/.bin/eslint $(ESLINT_IGNORE_PATH) --config $(LINT_PATH) --ext .jsx $(LINT_GLOB)

# Fix and lint our project
lint.fix: $(ESLINT_NODE_MODULES)
	@./node_modules/.bin/eslint $(ESLINT_IGNORE_PATH) --config $(LINT_PATH) --ext .jsx --fix $(LINT_GLOB)

# Lint our project and watch for changes
lint.watch: $(ESLINT_NODE_MODULES) node_modules/eslint-watch
	@./node_modules/.bin/esw $(ESLINT_IGNORE_PATH) --config $(LINT_PATH) -w --clear --ext .jsx --fix $(LINT_GLOB)

# Copy our eslint config into the project
# .eslintrc:
# 	@cp "$(DIR)/config/.eslintrc" "./.eslintrc"

# Download all eslint dependencies
$(ESLINT_NODE_MODULES):
	@yarn add -D $(notdir $@)

node_modules/eslint-watch:
	@yarn add -D eslint-watch