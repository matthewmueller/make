# Make

A personal collection of installable make commands

## Install

```
mkdir -p /usr/local/include/github.com/matthewmueller/make && curl -sL https://github.com/matthewmueller/make/archive/master.tar.gz | tar xz --strip-components=1 -C /usr/local/include/github.com/matthewmueller/make
```

## Usage

```make
# Run make test
default: test

include github.com/matthewmueller/make/help.mk
include github.com/matthewmueller/make/mocha.mk
include github.com/matthewmueller/make/lint.mk
include github.com/matthewmueller/make/git.mk

# Test our files using mocha
test: mocha

# Called before we commit code to git
precommit: lint test
```

## Thanks

  - [@tj](https://github.com/tj) showed how to do github-style imports with [mmake](https://github.com/tj/mmake)
  - [@ianstormtaylor](https://github.com/ianstormtaylor) created a great [make help](https://github.com/ianstormtaylor/makefile-help) command.

## License

MIT