.PHONY: build

build: node_modules
	npm run build

node_modules:
	npm i

start:
	BROWSER=none npm start

clean:
	rm -rf node_modules build
