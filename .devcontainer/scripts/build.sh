#!/usr/bin/env bash
# Installs all the necessary libraries so that it is done in a single layer during the Docker build process.
# More about what each script does can be found in their respective comments section located at the top of the files.
# Syntax: ./build.sh

source /home/tmp/build_config.sh
cat /home/tmp/build_config.sh

/bin/bash /home/tmp/libraries/pre-check.sh

/bin/bash /home/tmp/libraries/set-bash-aliases.sh

/bin/bash /home/tmp/libraries/debian-setup.sh "${USERNAME}" "${USER_GID}" "${USER_UID}" "${UPGRADE_PACKAGES}"

/bin/bash /home/tmp/libraries/docker.sh "${ENABLE_NONROOT_DOCKER}" "${USE_MOBY}" "${USERNAME}"

/bin/bash /home/tmp/libraries/mongodb.sh "${USE_MONGO}" "${MONGO_TOOLS_VERSION}"

/bin/bash /home/tmp/libraries/redis.sh "${USE_REDIS}" "${REDIS_TOOLS_VERSION}"

/bin/bash /home/tmp/libraries/node-package-managers.sh "${KEEP_NVM}" "${UPGRADE_GLOBALS}" "${USE_ANGULAR}" "${USE_NESTJS}" "${USE_NRWL}" "${USE_IONIC}" "${USERNAME}"

/bin/bash /home/tmp/libraries/clean-house.sh
