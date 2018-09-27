#!/bin/sh
set -efu
NAME="postgresql-build"
IMAGE="debian:testing-slim"
. ../include/lib
. ../include/debian-pre
POSTGRESQL_DATA="/srv/postgresql/data"
/usr/bin/rm -rf $POSTGRESQL_DATA
/usr/bin/mkdir -p $POSTGRESQL_DATA
RUN $APT_GET --no-install-recommends install postgresql locales
RUN $APT_GET clean
RUN $APT_GET autoremove
SH "echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen"
RUN /usr/sbin/locale-gen
CLR /tmp
CLR /var/tmp
CLR /var/lib/apt/lists
/usr/bin/buildah run -v $POSTGRESQL_DATA:/data $__CONTAINER -- /usr/bin/chown postgres:postgres /data
/usr/bin/buildah run -v $POSTGRESQL_DATA:/data $__CONTAINER -- /usr/bin/runuser postgres -c "/usr/lib/postgresql/10/bin/initdb --locale en_US.UTF-8 -E UTF8 -D '/data'"
CFG --entrypoint '["/usr/lib/postgresql/10/bin/postgres", "-c", "data_directory=/data", "-D", "/etc/postgresql/10/main", "-d", "5"]'
CFG --cmd ''
CFG --stop-signal TERM
