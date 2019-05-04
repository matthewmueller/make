## Git Commands

ifndef STD
include std.mk
endif

# Initialize .git
.git:
	@git init
	@git add --all
	@git commit -m "Initial commit"

# Install the .gitignore
.gitignore:
	@ cp ${CONFIG}/git/.gitignore ${@}

# Add a pre-commit hook that will run `make precommit` if we have it
.git/hooks/pre-commit: .git
	@ cp ${CONFIG}/git/pre-commit ${@}

## Setup git in your project
git.new: .gitignore .git .git/hooks/pre-commit

## Fail if we have uncommitted files
git.dirty:
	@git diff --quiet || $(error "working directory has uncommitted files")