FROM jekyll/jekyll:latest

COPY Gemfile Gemfile.lock ./
RUN set -eux \
  && bundle install

COPY . .
RUN set -eux \
  && bundle exec jekyll build

FROM nginx:alpine
COPY --from=0 /srv/jekyll/_site /usr/share/nginx/html