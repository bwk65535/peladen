FROM ruby:2.7.2-alpine3.12 AS builder

WORKDIR /app
RUN set -eux \
  && apk add -U gcc make ruby-dev build-base

COPY Gemfile Gemfile.lock ./
RUN set -eux \
  && bundle install

COPY . .
RUN set -eux \
  && bundle exec jekyll build

FROM nginx:alpine
COPY --from=builder /app/_site /usr/share/nginx/html