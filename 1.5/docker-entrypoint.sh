#!/bin/bash

if [ "$1" = 'mix' ]; then
  su-exec deploy fixuid
  set -- su-exec deploy "$@"
fi

exec "$@"
