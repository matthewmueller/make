DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

# Port to start next.js on (default: 3000)
PORT ?= 3000

# Dependencies
NEXT_DEPENDENCIES := next react react-dom
NEXT_NODE_MODULES := $(addprefix node_modules/, $(NEXT_DEPENDENCIES))
NEXT_DEV_DEPENDENCIES := babel-plugin-react-html-attrs @mdx-js/loader
NEXT_DEV_NODE_MODULES := $(addprefix node_modules/, $(NEXT_DEV_DEPENDENCIES))

# Start developing a fresh next.js project
next: $(NEXT_NODE_MODULES) $(NEXT_DEV_NODE_MODULES) next.init
	@./node_modules/.bin/next -p $(PORT)

# Initialize a new next.js project
next.init: static/favicon.ico pages/index.jsx pages/_document.jsx ./next.config.js

static:
	@mkdir -p ./static

pages:
	@mkdir -p ./pages

static/favicon.ico: static
	@cp $(DIR)/config/favicon.ico ./static

pages/index.jsx: pages
	@cp $(DIR)/config/next_index.jsx ./pages/index.jsx

pages/_document.jsx: pages
	@cp $(DIR)/config/next_document.jsx ./pages/_document.jsx

./next.config.js:
	@cp $(DIR)/config/next.config.js ./

$(NEXT_NODE_MODULES):
	@yarn add $(@:node_modules/%=%)

$(NEXT_DEV_NODE_MODULES):
	@yarn add -D $(@:node_modules/%=%)