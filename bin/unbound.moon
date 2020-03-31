#!/usr/bin/env moon
base = "docker://docker.io/library/alpine:edge"
main = ->
    RUN         "/sbin/apk upgrade --no-cache --available --no-progress"
    RUN         "/sbin/apk add --no-cache unbound"
    RM          "/var/cache/apk"
    ENTRYPOINT  "/usr/sbin/unbound"
    STORAGE     "unbound"
buildah = require"buildah".from base, main
buildah!
