FROM caddy:2-builder AS builder
RUN xcaddy build --with github.com/lindenlab/caddy-s3-proxy

FROM caddy:2
COPY --from=builder /usr/bin/caddy /usr/bin
