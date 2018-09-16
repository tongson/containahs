#!/bin/sh
set -efu
NAME="jre-build"
IMAGE="debian:testing-slim"
. ../include/lib
APT_GET="/usr/bin/env DEBIAN_FRONTEND=noninteractive apt-get -qq"
$MKDIR /usr/share/man/man1
$RUN /usr/bin/touch /usr/share/man/man1/sh.distrib.1.gz
$RUN $APT_GET update
$RUN $APT_GET dist-upgrade
$RUN $APT_GET --no-install-recommends install openjdk-8-jre openjdk-8-jre-headless locales
$RUN $APT_GET clean
$RUN $APT_GET autoremove
$CSH "echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen"
$RUN /usr/sbin/locale-gen
$CLEAN /tmp
$CLEAN /var/tmp
$CLEAN /var/lib/apt/lists
$CONFIG --entrypoint ''
$CONFIG --cmd ''
$CONFIG --stop-signal TERM
