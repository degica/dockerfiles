FROM ruby:2.3.1-slim

RUN apt-get update \
   && apt-get install -y --no-install-recommends \
      file \
      git \
      nodejs \
   && rm -rf /var/lib/apt/lists/* \
   && ln -s /usr/bin/nodejs /usr/bin/node

ONBUILD ARG APP_HOME=/app
ONBUILD ARG BUNDLE_OPTIONS='--without development test'
ONBUILD ARG SKIP_BUNDLE
ONBUILD RUN mkdir -p $APP_HOME
ONBUILD WORKDIR $APP_HOME
ONBUILD COPY Gemfile $APP_HOME/
ONBUILD COPY Gemfile.lock $APP_HOME/
ONBUILD ADD vendor $APP_HOME/vendor
ONBUILD RUN apt-get update && \
            runDeps=' \
              libmysqlclient18 \
              libpq5 \
              libsqlite3-0 \
              libxslt1.1 \
              libxml2 \
            ' && \
            buildDeps=' \
              autoconf \
              automake \
              g++ \
              gcc \
              libbz2-dev \
              libc6-dev \
              libevent-dev \
              libgeoip-dev \
              libglib2.0-dev \
              libjpeg-dev \
              liblzma-dev \
              libmagickcore-dev \
              libmagickwand-dev \
              libncurses-dev \
              libpng-dev \
              libreadline-dev \
              libtool \
              libwebp-dev \
              libxslt-dev \
              libmysqlclient-dev \
              libpq-dev \
              libsqlite3-dev \
              libxml2-dev \
              make \
            ' && \
            apt-get install -y --no-install-recommends $buildDeps && \
            test "$SKIP_BUNDLE" = "yes" || \
            ( bundle install -j 8 $BUNDLE_OPTIONS && \
              apt-get purge -y --auto-remove $buildDeps && \
              apt-get install -y --no-install-recommends $runDeps && \
              rm -rf /var/lib/apt/lists/* )
