.PHONY: build
build:
	BUILD_TARGET=caddy \
		docker compose build --build-arg HOSTNAME=$$(hostname)


.PHONY: build-with-tailscale
build-with-tailscale:
	BUILD_TARGET=caddy-ts \
		docker compose build --build-arg HOSTNAME=$$(hostname)
