FROM outstand/elixir:1.4.5
MAINTAINER Ryan Schlesinger <ryan@outstand.com>

RUN useradd -ms /bin/bash deploy && \
      curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
      apt-get install -y nodejs inotify-tools && \
      rm -rf /var/lib/apt/lists/*

ENV FSCONSUL_VERSION 0.6.4.1

RUN mkdir -p /tmp/build && \
    cd /tmp/build && \
    wget -O - https://keybase.io/outstand/pgp_keys.asc | gpg --import && \
    wget -O fsconsul "https://s3.amazonaws.com/outstand-publish/fsconsul-${FSCONSUL_VERSION}" && \
    wget -O fsconsul.asc "https://s3.amazonaws.com/outstand-publish/fsconsul-${FSCONSUL_VERSION}.asc" && \
    gpg --verify fsconsul.asc && \
    chmod +x fsconsul && \
    cp fsconsul /bin/fsconsul && \
    cd /tmp && \
    rm -rf /tmp/build && \
    rm -rf /root/.gnupg

ENV YARN_VERSION 0.24.6

RUN set -ex \
  && for key in \
    6A010C5166006599AA17F08146C2130DFD2497F5 \
  ; do \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" || \
    gpg --keyserver pgp.mit.edu --recv-keys "$key" || \
    gpg --keyserver keyserver.pgp.com --recv-keys "$key" ; \
  done \
  && curl -fSL -o yarn.js "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-legacy-$YARN_VERSION.js" \
  && curl -fSL -o yarn.js.asc "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-legacy-$YARN_VERSION.js.asc" \
  && gpg --batch --verify yarn.js.asc yarn.js \
  && rm yarn.js.asc \
  && mv yarn.js /usr/local/bin/yarn \
  && chmod +x /usr/local/bin/yarn

ENV PHOENIX_VERSION 1.2.4

RUN gosu deploy mix local.hex --force && \
      gosu deploy mix local.rebar --force && \
      gosu deploy mix archive.install --force \
        https://github.com/phoenixframework/archives/raw/master/phoenix_new-${PHOENIX_VERSION}.ez
