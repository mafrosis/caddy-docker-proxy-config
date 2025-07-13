.PHONY: build
build:
	docker compose build \
		--build-arg HOSTNAME=$$(hostname)
