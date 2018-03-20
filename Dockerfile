FROM outstand/elixir:1.6.4
MAINTAINER Ryan Schlesinger <ryan@outstand.com>

RUN useradd -ms /bin/bash deploy && \
      curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
      apt-get install -y nodejs inotify-tools && \
      rm -rf /var/lib/apt/lists/*

ENV YARN_VERSION 1.5.1

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

ENV PHOENIX_VERSION 1.3.2

RUN gosu deploy mix local.hex --force && \
      gosu deploy mix local.rebar --force && \
      gosu deploy mix archive.install --force \
        https://github.com/phoenixframework/archives/raw/master/phx_new-${PHOENIX_VERSION}.ez
