FROM 786715713882.dkr.ecr.us-east-1.amazonaws.com/phoenix:1.5.9-alpine-3.13
LABEL maintainer="Ryan Schlesinger <ryan@outstand.com>"

RUN echo "@edge http://dl-cdn.alpinelinux.org/alpine/edge/community/" >> /etc/apk/repositories && \
      apk add --no-cache \
      xvfb \
      xdpyinfo \
      harfbuzz \
      nss \
      freetype \
      ttf-freefont \
      chromium \
      chromium-chromedriver
      # chromium@edge \
      # chromium-chromedriver@edge
