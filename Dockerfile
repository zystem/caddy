FROM golang:1.24-alpine AS builder

RUN apk add --no-cache git

RUN git clone https://github.com/zystem/caddy.git /src/caddy
WORKDIR /src/caddy

RUN go get github.com/zystem/caddy-webdav

RUN go build -o /caddy ./cmd/caddy

FROM alpine:3.19
COPY --from=builder /caddy /usr/bin/caddy
CMD ["caddy","run","--config","/etc/caddy/Caddyfile","--adapter","caddyfile"]