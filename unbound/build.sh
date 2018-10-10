#!/bin/sh
set -efu
NAME="unbound-build"
FROM="debian:testing-slim"
UNBOUND="/srv/unbound"
mkdir -p $UNBOUND
OPTS="-v $UNBOUND:/etc/unbound:Z"
. ../include/lib
. ../include/debian-pre
RUN $APT_GET --no-install-recommends install unbound locales
RUN $APT_GET clean
RUN $APT_GET autoremove
SH "echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen"
RUN /usr/sbin/locale-gen
CLR /tmp
CLR /var/tmp
CLR /var/lib/apt/lists
CFG --entrypoint '["/usr/sbin/unbound", "-c", "/etc/unbound/unbound.conf", "-v"]'
CFG --cmd ''
CFG --stop-signal TERM
