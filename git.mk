DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

# Install git hooks into our project
git.install: .gitignore .git
	@cp $(DIR)/config/pre-commit .git/hooks/pre-commit

git.unchanged:
	@git diff --quiet || (echo 'git is dirty'; exit 1)

# Install a default .gitignore
.gitignore:
	@echo "installing gitignore"
	@cp $(DIR)/config/.gitignore .gitignore

.git:
	@git init
	@git add --all
	@git commit -m "Initial commit"
