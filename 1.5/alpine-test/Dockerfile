FROM outstand/phoenix:1.5.3-alpine
LABEL maintainer="Ryan Schlesinger <ryan@outstand.com>"

RUN echo "@edge http://dl-cdn.alpinelinux.org/alpine/edge/community/" >> /etc/apk/repositories && \
      apk add --no-cache \
      xvfb \
      xdpyinfo \
      harfbuzz \
      nss \
      freetype \
      ttf-freefont \
      chromium@edge \
      chromium-chromedriver@edge
