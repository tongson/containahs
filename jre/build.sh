#!/bin/sh
set -efu
NAME="jre-build"
IMAGE="debian:testing-slim"
. ../include/lib
. ../include/debian-pre
RUN $APT_GET --no-install-recommends install openjdk-8-jre openjdk-8-jre-headless locales
RUN $APT_GET clean
RUN $APT_GET autoremove
SH "echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen"
RUN /usr/sbin/locale-gen
CLR /tmp
CLR /var/tmp
CLR /var/lib/apt/lists
CFG --entrypoint ''
CFG --cmd ''
CFG --stop-signal TERM
