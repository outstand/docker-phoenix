#!/bin/bash

if [ "$1" = 'mix' ]; then
  set -- su-exec deploy "$@"
fi

exec "$@"
