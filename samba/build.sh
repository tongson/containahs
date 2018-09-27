#!/bin/sh
set -efu
NAME="samba-build"
IMAGE="alpine:edge"
. ../include/lib
RUN /sbin/apk upgrade --no-cache --available --no-progress
RUN /sbin/apk add --no-cache --no-progress samba
CLR /tmp
CFG --entrypoint ''
CFG --cmd '/usr/sbin/smbd -F -S -d1 -P0 --no-process-group'
CFG --stop-signal TERM
