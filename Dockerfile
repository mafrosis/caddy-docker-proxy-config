ARG CADDY_DOCKER_TAG

FROM caddy:${CADDY_DOCKER_TAG}-builder AS builder

ARG CADDY_DOCKER_PROXY_PLUGIN
ARG CADDY_GANDI_PLUGIN

RUN xcaddy build \
	--with "github.com/lucaslorentz/caddy-docker-proxy/v2@${CADDY_DOCKER_PROXY_PLUGIN}" \
	--with "github.com/caddy-dns/gandi@${CADDY_GANDI_PLUGIN}"


FROM caddy:${CADDY_DOCKER_TAG}-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

CMD ["caddy", "docker-proxy"]
