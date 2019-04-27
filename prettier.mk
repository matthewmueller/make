SRC?=**/*.+(js|jsx|ts|tsx|json)

prettier: node_modules/.bin/prettier
	@./node_modules/.bin/prettier \
		--jsx-bracket-same-line \
		--print-width 100 \
		--prose-wrap always \
		--no-semi \
		--single-quote \
		--tab-width 2 \
		--trailing-comma none \
		--write \
		"$(SRC)"

node_modules/.bin/prettier:
	@yarn add -D prettier
