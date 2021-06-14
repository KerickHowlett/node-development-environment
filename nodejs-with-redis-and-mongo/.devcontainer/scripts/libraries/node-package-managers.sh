#!/usr/bin/env bash
# Installs & Configures Global Node Dependencies & Command Line Tools.
# Syntax: ./package-manager.sh [boolean] [boolean] [boolean] [boolean] [boolean] [boolean]

KEEP_NVM=${6:-"false"}
UPGRADE_GLOBALS=${1:-"true"}
USE_ANGULAR=${2:-"false"}
USE_NESTJS=${3:-"false"}
USE_NRWL=${4:-"false"}
USE_IONIC=${5:-"false"}
USERNAME=${6:-"node"}

remove-nvm()
{
    if [ "$KEEP_NVM" != "true" ]; then
        NVM_EXPORTS=$(which -a nvm)
        unset ${NVM_EXPORTS}
        echo "NVM has been removed."
    fi
}

remove-nvm

update-global-packages()
{
    if [ "${UPGRADE_GLOBALS}" != "true" ]; then
        echo "Updating package managers..."
        OUTDATED_PACKAGES= npm outdated -g | grep "node_modules/*" | awk '{ print $1 }'
        if [ -z "${OUTDATED_PACKAGES}" ]; then
            npm install --global --quiet ${OUTDATED_PACKAGES}
        fi
        yarn global upgrade
        echo "The following node dependencies have been updated: ${OUTDATED_PACKAGES}"
    fi
}

# # Install latest package managers.
if [ "${PACKAGE_MANAGERS_ALREADY_INSTALLED}" != "true" ]; then
    PACKAGE_MANAGERS_LIST="\
        npm \
        pnpm \
        yarn \
    "
    echo "Installing Package Managers: ${PACKAGE_MANAGERS_LIST}"
    npm install --global --quiet ${PACKAGE_MANAGERS_LIST}
    $PACKAGE_MANAGERS_ALREADY_INSTALLED = "true"
    echo "All package managers are installed to the latest version."
fi

update-global-packages

# Insall binaries as dependencies for specific Node command line tools.
if [ "$NODE_BINARIES_ARE_ALREADY_INSTALLED" != "true" ]; then
    NODE_BINARIES_LIST="\
        node-gyp \
        node-sass \
        puppeteer \
    "
    echo "Installing Node Binaries: ${NODE_BINARIES_LIST}"
    npm install --global --quiet --unsafe-perm $NODE_BINARIES_LIST
    $NODE_BINARIES_ARE_ALREADY_INSTALLED = "true"
    echo "All node binaries are installed to the latest version."
fi

# # Install global npm command line tools.
if [ "${GLOBAL_TOOLS_ARE_ALREADY_INSTALLED}" != "true" ]; then
    GLOBAL_TOOLS="\
        commitizen \
        http-server \
        ndb \
        npm-check \
        npm-check-updates \
        pm2 \
        rimraf \
        snyk \
        typescript \
        @commitlint/cli \
    "
    echo "Installing Global NPM Tools: ${GLOBAL_TOOLS}"
    npm install --global --quiet $GLOBAL_TOOLS
    $GLOBAL_TOOLS_ARE_ALREADY_INSTALLED = "true"
    echo "All Global NPM Tools Are Installed."
fi

# Installs Angular Command Line Tools
if [ "${USE_ANGULAR}" = "true" ]; then
    if [ "${ANGULAR_ALREADY_INSTALLED}" != "true" ]; then
        npm install --global @angular/cli
        ANGULAR_ALREADY_INSTALLED = "true"
        echo "Angular command line tools are installed."
    fi
fi

# Installs NestJS Command Line Tools
if [ "$USE_NESTJS" = "true" ]; then
    if [ "${NESTJS_ALREADY_INSTALLED}" != "true" ]; then
        npm install --global --quiet @nestjs/cli
        NESTJS_ALREADY_INSTALLED = "true"
        echo "NestJS command line tools are installed."
    fi
fi

# Installs NestJS Command Line Tools
if [ "$USE_NRWL" = "true" ]; then
    if [ "${NRWL_ALREADY_INSTALLED}" != "true" ]; then
        npm install --global --quiet @nrwl/cli
        NRWL_ALREADY_INSTALLED = "true"
        echo "NRWL/Nx command line tools are installed."
    fi
fi

# Installs tools for Hybrid Mobile WebView App Development via Ionic Framework.
if [ "$USE_IONIC" = "true" && IONIC_ALREADY_INSTALLED != "true" ]; then
    if [ "${IONIC_ALREADY_INSTALLED}" != "true" ]; then
        npm install --global --quiet @capacitor/cli @ionic/cli cordova
        IONIC_ALREADY_INSTALLED = "true"
        echo "The command lines for Capacitor, Cordova, and Ionic were installed."
    fi
fi

# Configures Yarn.
yarn config set ignore-engines true
yarn config set workspaces-experimental true

yarn config set cache-folder /home/node/.cache

echo "Configured Yarn for development:"
yarn config list

update-global-packages