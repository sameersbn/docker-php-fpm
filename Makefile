all: build

build:
	@docker build --tag=${USER}/php5-fpm .
