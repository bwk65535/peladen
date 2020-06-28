FROM jekyll/jekyll:latest as builder
WORKDIR /app
COPY . .
RUN set -eux \
  && chown -R jekyll:jekyll /app \
  && bundle exec jekyll build --trace

FROM nginx:alpine
COPY --from=builder /app/_site /usr/share/nginx/html
