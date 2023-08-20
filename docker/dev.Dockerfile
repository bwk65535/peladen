FROM ruby:3

# Add jekyll user
RUN set -eux \
  && groupadd --gid 1000 jekyll \
  && useradd --uid 1000 --gid 1000 --create-home jekyll

# EnvVars
ENV BUNDLE_HOME=/usr/local/bundle
ENV BUNDLE_APP_CONFIG=/usr/local/bundle
ENV BUNDLE_DISABLE_PLATFORM_WARNINGS=true
ENV BUNDLE_BIN=/usr/local/bundle/bin
ENV GEM_HOME=/home/jekyll/gems
ENV GEM_BIN=/home/jekyll/gems/bin
ENV RUBYOPT=-W0
ENV JEKYLL_VAR_DIR=/var/jekyll
ENV JEKYLL_DATA_DIR=/srv/jekyll
ENV JEKYLL_BIN=/usr/jekyll/bin
ENV JEKYLL_ENV=development
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV TZ=Asia/Jakarta
ENV PATH="$JEKYLL_BIN:$GEM_BIN:$PATH"
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US

# Install prerequisites
# RUN set -eux \
#   && apt -y update \
#   && apt -y install ruby-full build-essential

# Install jekyll and bundler
RUN set -eux \
  && gem install jekyll bundler

# Fix permission and cleanups
RUN set -eux \
  && mkdir -p $JEKYLL_VAR_DIR \
  && mkdir -p $JEKYLL_DATA_DIR \
  && chown -R jekyll:jekyll $JEKYLL_DATA_DIR \
  && chown -R jekyll:jekyll $JEKYLL_VAR_DIR \
  && chown -R jekyll:jekyll $BUNDLE_HOME \
  && chown -R jekyll:jekyll $GEM_HOME
#   && rm -rf /home/jekyll/.gem \
#   && rm -rf $BUNDLE_HOME/cache \
#   && rm -rf $GEM_HOME/cache \
#   && rm -rf /root/.gem

USER jekyll
CMD ["jekyll", "--help"]
WORKDIR /srv/jekyll
VOLUME /usr/local/bundle
VOLUME /home/jekyll/gems
EXPOSE 35729
EXPOSE 4000