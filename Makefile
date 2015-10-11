all: build

build:
	@docker build --tag=quay.io/sameersbn/php5-fpm .
