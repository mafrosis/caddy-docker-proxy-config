.PHONY: build
build:
	docker compose build \
		--build-arg BUILD_TARGET=caddy \
		--build-arg HOSTNAME=$$(hostname)


.PHONY: build-with-tailscale
build-with-tailscale:
	docker compose build \
		--build-arg BUILD_TARGET=caddy-ts \
		--build-arg HOSTNAME=$$(hostname)
