FROM jekyll/jekyll:4.1.0 as builder

COPY Gemfile Gemfile.lock ./
RUN set -eux \
  && bundle install

COPY . .
RUN set -eux \
  && bundle exec jekyll build --trace

FROM nginx:alpine
COPY --from=builder /var/jekyll/_site /usr/share/nginx/html