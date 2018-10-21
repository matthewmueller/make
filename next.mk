DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

# Port to start next.js on (default: 3000)
PORT ?= 3000

# Dependencies
NEXT_DEPENDENCIES := next react react-dom
NEXT_NODE_MODULES := $(addprefix node_modules/, $(NEXT_DEPENDENCIES))
NEXT_DEV_DEPENDENCIES := babel-plugin-react-html-attrs @mdx-js/loader
NEXT_DEV_NODE_MODULES := $(addprefix node_modules/, $(NEXT_DEV_DEPENDENCIES))
NEXT_FILES := static/favicon.ico pages/index.jsx pages/_document.jsx ./next.config.js

# Start developing a fresh next.js project
next: $(NEXT_NODE_MODULES) $(NEXT_DEV_NODE_MODULES) $(NEXT_FILES)
	@./node_modules/.bin/next -p $(PORT)

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

$(NEXT_NODE_MODULES):
	@yarn add $(@:node_modules/%=%)

$(NEXT_DEV_NODE_MODULES):
	@yarn add -D $(@:node_modules/%=%)