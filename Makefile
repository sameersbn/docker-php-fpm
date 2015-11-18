all: build

build:
	@docker build --tag=sameersbn/php5-fpm .
