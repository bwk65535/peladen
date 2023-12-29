FROM alpine:3 as builder

# Add hugo user
RUN set -eux \
  && addgroup -g 1000 hugo \
  && adduser -u 1000 -G hugo -D hugo

# Install prerequisites
RUN set -eux \
  && apk add --no-cache git

# Install hugo
RUN set -eux \
  && apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community hugo \
  && hugo version

# Add workdir
RUN set -eux \
  && mkdir -p /home/hugo/app \
  && mkdir -p /tmp/hugo_cache \
  && chown -R hugo:hugo /home/hugo/app \
  && chown -R hugo:hugo /tmp/hugo_cache

USER hugo
WORKDIR /home/hugo/app

COPY --chown=hugo:hugo . .
RUN set -eux \
  && hugo --gc --minify

FROM nginxinc/nginx-unprivileged:alpine
COPY --from=builder /home/hugo/app/public /usr/share/nginx/html