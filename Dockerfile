ARG CADDY_DOCKER_TAG

FROM caddy:${CADDY_DOCKER_TAG}-builder AS builder

ARG CADDY_DOCKER_PROXY_PLUGIN
ARG CADDY_GANDI_PLUGIN

RUN xcaddy build \
	--with "github.com/lucaslorentz/caddy-docker-proxy/v2@${CADDY_DOCKER_PROXY_PLUGIN}" \
	--with "github.com/caddy-dns/gandi@${CADDY_GANDI_PLUGIN}" \
	--with "github.com/tailscale/caddy-tailscale"


FROM caddy:${CADDY_DOCKER_TAG}-alpine

ARG CADDY_DOCKER_TAG
ARG CADDY_DOCKER_PROXY_PLUGIN
ARG CADDY_GANDI_PLUGIN
ARG HOSTNAME
ENV CADDY_DOCKER_TAG=${CADDY_DOCKER_TAG}
ENV CADDY_DOCKER_PROXY_PLUGIN=${CADDY_DOCKER_PROXY_PLUGIN}
ENV CADDY_GANDI_PLUGIN=${CADDY_GANDI_PLUGIN}
ENV HOSTNAME=${HOSTNAME}
ENV CADDY_DOCKER_CADDYFILE_PATH=/Caddyfile

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

# Base Caddyfile extended by docker-proxy
COPY Caddyfile.${HOSTNAME} /Caddyfile

CMD ["caddy", "docker-proxy"]
