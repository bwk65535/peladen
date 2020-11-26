FROM jekyll/jekyll:4.1.0 as builder
USER jekyll
WORKDIR /app

COPY --chown=jekyll Gemfile Gemfile.lock ./
RUN set -eux \
  && bundle install

COPY --chown=jekyll . .
RUN set -eux \
  && bundle exec jekyll build --trace

FROM nginx:alpine
COPY --from=builder /app/_site /usr/share/nginx/html