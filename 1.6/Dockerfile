FROM outstand/yarn as yarn
FROM outstand/fixuid as fixuid

FROM outstand/elixir:1.13.1
LABEL maintainer="Ryan Schlesinger <ryan@outstand.com>"

RUN groupadd -g 1000 deploy && \
      useradd -u 1000 -g deploy -ms /bin/bash deploy && \
      curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
      apt-get install -y nodejs inotify-tools && \
      rm -rf /var/lib/apt/lists/*

COPY --from=fixuid /usr/local/bin/fixuid /usr/local/bin/fixuid
COPY --from=fixuid /etc/fixuid/config.yml /etc/fixuid/config.yml
RUN chmod 4755 /usr/local/bin/fixuid

COPY --from=yarn /bin/yarn /bin/

ENV PHOENIX_VERSION 1.6.4

RUN su-exec deploy mix local.hex --force && \
      su-exec deploy mix local.rebar --force && \
      su-exec deploy mix archive.install --force hex phx_new ${PHOENIX_VERSION}

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/sbin/tini", "-g", "--", "/docker-entrypoint.sh"]
