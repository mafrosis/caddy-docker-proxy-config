ARG CADDY_VERSION=2.6.2
ARG CADDY_GANDI_PLUGIN=v1.0.2
ARG CADDY_DOCKER_PROXY_PLUGIN=v2.8.2


FROM caddy:${CADDY_VERSION}-builder AS builder

RUN xcaddy build \
	--with "github.com/lucaslorentz/caddy-docker-proxy/v2@${CADDY_DOCKER_PROXY_PLUGIN}" \
	--with "github.com/caddy-dns/gandi@${CADDY_GANDI_PLUGIN}"


FROM caddy:${CADDY_VERSION}-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

CMD ["caddy", "docker-proxy"]
