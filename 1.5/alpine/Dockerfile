FROM outstand/yarn as yarn
FROM outstand/fixuid as fixuid

FROM 786715713882.dkr.ecr.us-east-1.amazonaws.com/elixir:1.12.2-alpine-3.13
LABEL maintainer="Ryan Schlesinger <ryan@outstand.com>"

RUN addgroup -g 1000 -S deploy && \
    adduser -u 1000 -S -s /bin/bash -G deploy deploy && \
    apk add --no-cache \
      ca-certificates \
      wget \
      curl \
      openssl \
      jq \
      git \
      bash \
      nodejs \
      gnupg \
      inotify-tools

COPY --from=fixuid /usr/local/bin/fixuid /usr/local/bin/fixuid
COPY --from=fixuid /etc/fixuid/config.yml /etc/fixuid/config.yml
RUN chmod 4755 /usr/local/bin/fixuid

COPY --from=yarn /bin/yarn /bin/

ENV PHOENIX_VERSION 1.5.9

RUN su-exec deploy mix local.hex --force && \
      su-exec deploy mix local.rebar --force && \
      su-exec deploy mix archive.install --force hex phx_new ${PHOENIX_VERSION}

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/sbin/tini", "-g", "--", "/docker-entrypoint.sh"]
