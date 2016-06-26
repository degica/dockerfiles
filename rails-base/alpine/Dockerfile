FROM ruby:2.3-alpine

RUN apk add --no-cache --virtual .rundeps \
    bash \
    git \
		ca-certificates \
    mariadb-client-libs \
    libpq \
    tzdata \
    libxml2-dev \
    libxslt-dev \
    openssl-dev \
    zlib-dev \
		yaml-dev \
    nodejs

ONBUILD ARG APP_HOME=/app
ONBUILD ARG BUNDLE_OPTIONS='--without development test'
ONBUILD RUN mkdir -p $APP_HOME
ONBUILD WORKDIR $APP_HOME

ONBUILD COPY Gemfile $APP_HOME/
ONBUILD COPY Gemfile.lock $APP_HOME/
ONBUILD ADD vendor $APP_HOME/vendor
ONBUILD RUN apk add --no-cache --virtual .builddeps \
              autoconf \
              bzip2-dev \
              ca-certificates \
              coreutils \
              g++ \
              gcc \
              gdbm-dev \
              glib-dev \
              libc-dev \
              libffi-dev \
              linux-headers \
              mysql-dev \
              make \
              ncurses-dev \
              procps \
          		readline-dev \
          		zlib-dev \
         && bundle install -j 8 $BUNDLE_OPTIONS \
         && apk del .builddeps
