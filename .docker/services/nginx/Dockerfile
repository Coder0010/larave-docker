FROM node:16-alpine AS node
FROM nginx:1.20-alpine
SHELL ["/bin/sh", "-oeux", "pipefail", "-c"]

ENV TZ=UTC

RUN apk update && \
    apk add --no-cache g++ && \
    apk add --no-cache --virtual .build-dependencies build-base && \
    apk del .build-dependencies && \
    apk add --no-cache libmagic && \
    rm -rf /var/cache/apk/*

# node command
COPY --from=node /usr/local/bin /usr/local/bin
# npm command
COPY --from=node /usr/local/lib /usr/local/lib
# yarn command
COPY --from=node /opt /opt

ARG DOCKER_SERVICES_PATH
COPY ${DOCKER_SERVICES_PATH}/nginx/conf.d/domain.conf /etc/nginx/conf.d/default.conf

WORKDIR /var/www
