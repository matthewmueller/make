# Make

Functional Makefile utilities

## Install

```sh
curl -L https://raw.githubusercontent.com/matthewmueller/make/master/install.sh | sh
```

## Usage

**Include all utilities**

```make
include github.com/matthewmueller/make/all.mk
```

**Include individual utilities**

```make
include github.com/matthewmueller/make/help.mk
include github.com/matthewmueller/make/env.mk
include github.com/matthewmueller/make/bin.mk
include github.com/matthewmueller/make/read.mk
```

## Test

```
./test/all.bats
```

## License

MIT
