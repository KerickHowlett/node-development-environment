#!/usr/bin/env bash
# These are used as easily configurable arguments used for the build process.

IS_LOADED="true"

# Major JavaScript-based framework command line tools.
KEEP_NVM="false"
UPGRADE_GLOBALS="true"
USE_ANGULAR="true"
USE_IONIC="false"
USE_NESTJS="true"
USE_NRWL="true"

# File System credentials for Bash & Docker configurations.
UPGRADE_PACKAGES="true"
USER_GID="1000"
USER_UID="1000"
USERNAME="node"

# Docker/Moby CLI configurations.
USE_MOBY="false"
ENABLE_NONROOT_DOCKER="true"

# MongoDB Network Environment Configration
MONGO_HOST="node-development-environment-database"
MONGO_PORT="6379"

# MongoDB Configuration.
USE_MONGO="true"
MONGO_IMAGE_VARIANT="4.4.6-bionic"
MONGO_TOOLS_VERSION="5.0"

# Redis Network Environment Configration
REDIS_HOST="node-development-environment-cache"
REDIS_PORT="27017"

# Redis Configuration.
USE_REDIS="true"
REDIS_IMAGE_VARIANT="6.2.3-alpine"
REDIS_TOOLS_VARIANT="6.2.3"