#!/usr/bin/env bash
# This is to create symlinks to the logs for debugging purposes.
# Syntax: ./configure-logs.sh

ln -sf /dev/stdout /home/node/logs/access.log
ln -sf /dev/stderr /home/node/logs/error.log 