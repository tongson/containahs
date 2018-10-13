#!/bin/sh
set -efu
NAME="configi"
FROM="debian:unstable-slim"
DATA="/srv/configi"
mkdir -p $DATA
OPTS="-v $DATA:/root:Z"
. ../include/lib
. ../include/debian-pre
RUN $APT_GET --no-install-recommends install locales build-essential git ca-certificates less vim
RUN $APT_GET clean
RUN $APT_GET autoremove
SH "echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen"
RUN /usr/sbin/locale-gen
CLR /tmp
CLR /var/tmp
CLR /var/lib/apt/lists
SH "git clone https://github.com/Configi/configi /root/configi "
CFG --entrypoint ''
CFG --cmd ''
CFG --stop-signal TERM
