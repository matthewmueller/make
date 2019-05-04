DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

# Port to start elmo.js on (default: 3000)
PORT ?= 3000

# Dependencies
ELMO_DEPENDENCIES := elmo preact
ELMO_NODE_MODULES := $(addprefix node_modules/, $(ELMO_DEPENDENCIES))
ELMO_DEV_NODE_MODULES := $(addprefix node_modules/, $(ELMO_DEV_DEPENDENCIES))

# Start developing a fresh elmo project
elmo: $(ELMO_NODE_MODULES) $(ELMO_DEV_NODE_MODULES) elmo.init
	@./node_modules/.bin/elmo serve $(PORT)

# Build an elmo site
elmo.build: $(ELMO_NODE_MODULES) $(ELMO_DEV_NODE_MODULES) elmo.init
	@./node_modules/.bin/elmo build

# Initialize a new elmo.js project
elmo.init: static/favicon.ico pages/index.jsx pages/_document.jsx

static:
	@mkdir -p ./static

pages:
	@mkdir -p ./pages

static/favicon.ico: static
	@cp $(DIR)/config/favicon.ico ./static

pages/index.jsx: pages
	@cp $(DIR)/config/elmo_index.jsx ./pages/index.jsx

pages/_document.jsx: pages
	@cp $(DIR)/config/elmo_document.jsx ./pages/_document.jsx

$(ELMO_NODE_MODULES):
	@yarn add $(@:node_modules/%=%)

$(ELMO_DEV_NODE_MODULES):
	@yarn add -D $(@:node_modules/%=%)