#!/usr/bin/env bash
# Download of Redis Server command line tools. (Optional)
# Syntax: ./redis.sh [enable redis server command line tools installation] [version number of redis server command line tools]

USE_REDIS=${1:-"true"}
REDIS_TOOLS_VERSION=${2:-"6.2.3"}

if [ USE_REDIS == "true" ]; then
    wget "https://download.redis.io/releases/redis-${REDIS_TOOLS_VERSION}.tar.gz" -O  /home/tmp/libraries/redis-tools.tar.gz
    tar xzf /home/tmp/libraries/redis-tools.tar.gz
    make
    echo "Finished installing Redis Server."
fi