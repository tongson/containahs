#!/usr/bin/env moon
base = "docker://docker.io/library/alpine:edge"
main = ->
    RUN         "/sbin/apk upgrade --no-cache --available --no-progress"
    RUN         "/sbin/apk add --no-cache nginx"
    RM          "/var/cache/apk"
    ENTRYPOINT  "/usr/sbin/nginx"
    STORAGE     "nginx"
buildah = require"buildah".from base, main
buildah!
