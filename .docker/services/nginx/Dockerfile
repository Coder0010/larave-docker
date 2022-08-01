FROM node:16-alpine as node
FROM nginx:1.20-alpine
SHELL ["/bin/sh", "-oeux", "pipefail", "-c"]

ENV TZ=UTC

RUN apk update && apk add --update --no-cache --virtual=.build-dependencies g++

# node command
COPY --from=node /usr/local/bin /usr/local/bin
# npm command
COPY --from=node /usr/local/lib /usr/local/lib
# yarn command
COPY --from=node /opt /opt

ARG DOCKER_SERVICES_PATH
COPY ${DOCKER_SERVICES_PATH}/nginx/conf.d/domain.conf /etc/nginx/conf.d/default.conf

WORKDIR /var/www
