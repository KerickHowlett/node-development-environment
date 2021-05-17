#!/usr/bin/env bash
# Download of MongoDB command line tools. (Optional)
# Syntax: ./mongo.sh [enable mongo command line tools installation] [version number of mongo command line tools]

USE_MONGO=${1:-"true"}
MONGO_TOOLS_VERSION=${2:-"5.0"}

if [ "$USE_MONGO" == "true" ]; then
    curl -sSL "https://www.mongodb.org/static/pgp/server-${MONGO_TOOLS_VERSION}.asc" | ( OUT=$( apt-key add - 2>&1 ) || echo $OUT )
    echo "deb http://repo.mongodb.org/apt/debian $(lsb_release -cs)/mongodb-org/${MONGO_TOOLS_VERSION} main" | tee /etc/apt/sources.list.d/mongodb-org-${MONGO_TOOLS_VERSION}.list
    apt-get install -y --no-install-recommends mongodb-org-tools mongodb-org-shell
    echo "Finished installing Mongo Command Line Tools."
fi