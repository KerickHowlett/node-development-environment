ARG NODE_VARIANT=14
FROM mcr.microsoft.com/vscode/devcontainers/typescript-node:0-$NODE_VARIANT
LABEL author="Kerick Howlett"

ARG MONGO_HOST="node-development-environment-database"
ARG MONGO_PORT="6379"
ARG REDIS_HOST="node-development-environment-cache"
ARG REDIS_PORT="27017"

ENV MONGO_HOST $MONGO_HOST
ENV MONGO_PORT $MONGO_PORT
ENV REDIS_HOST $REDIS_HOST
ENV REDIS_PORT $REDIS_PORT

# Copy over files needed for DevContainer's configuration & setup.
COPY ./scripts /home/tmp

# Install Global Node dependencies.
RUN /bin/bash /home/tmp/build.sh

# Switch User to node to better alleviate any potential permissions issues.
USER node

# Execute container and launch
ENTRYPOINT [ "/usr/local/share/docker-init.sh" ]
CMD [ "sleep", "infinity" ]