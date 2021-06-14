ARG REDIS_VARIANT="latest"
FROM redis:${REDIS_VARIANT}
LABEL author="Kerick Howlett"

ARG REDIS_HOST=redis://redis-cache
ARG REDIS_PORT=6379

# Establish Environment Variables for both Docker & Node.
ENV REDIS_HOST=$REDIS_HOST \
    REDIS_PORT=$REDIS_PORT \
    TZ=America/Kentucky/Louisville

# Copy over config files for Redis system.
COPY ./redis/redis.conf /usr/local/etc/redis/redis.conf
COPY ./redis/sysctl.conf /etc/sysctl.conf
COPY ./redis/enabled /sys/kernel/mm/transparent_hugepage/enabled
COPY ./redis/enabled /etc/rc.local/

# Execute container.
CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]
