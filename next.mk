DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

# Port to start next.js on (default: 3000)
PORT ?= 3000

# Dependencies
NEXT_DEPENDENCIES := next react react-dom babel-plugin-react-html-attrs
NEXT_NODE_MODULES := $(addprefix node_modules/, $(NEXT_DEPENDENCIES))

# Start developing a fresh next.js project
next: $(NEXT_NODE_MODULES) next.init
	@./node_modules/.bin/next -p $(PORT)

# Initialize a fresh next.js project
next.init: static/favicon.ico pages/index.jsx pages/_document.jsx ./next.config.js

static/favicon.ico:
	@mkdir -p ./static
	@cp $(DIR)/config/favicon.ico ./static

pages/index.jsx:
	@mkdir -p ./pages
	@cp $(DIR)/config/index.jsx ./pages

pages/_document.jsx:
	@mkdir -p ./pages
	@cp $(DIR)/config/_document.jsx ./pages

./next.config.js:
	@cp $(DIR)/config/next.config.js ./

node_modules/@mdx-js/loader:
	@yarn add -D @mdx-js/loader

$(NEXT_NODE_MODULES):
	@yarn add -D $(notdir $@)