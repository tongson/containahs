#!/usr/bin/env moon
buildah = require"buildah".from "docker://docker.io/library/alpine:edge"
RUN         "/sbin/apk upgrade --no-cache --available --no-progress"
RUN         "/sbin/apk add --no-cache unbound"
RM          "/var/cache/apk"
ENTRYPOINT  "/usr/sbin/unbound"
STORAGE     "unbound"
