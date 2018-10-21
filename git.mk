DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

# Setup and install git hooks into our project
git.setup: .gitignore .git
	@cp $(DIR)/config/pre-commit .git/hooks/pre-commit

# Install a default .gitignore
.gitignore:
	@echo "installing gitignore"
	@cp $(DIR)/config/.gitignore .gitignore

.git:
	@git init
	@git add --all
	@git commit -m "Initial commit"
