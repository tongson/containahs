#!/bin/sh
set -efu
NAME="mariadb-build"
FROM="debian:testing-slim"
MARIADB_DATA="/srv/mariadb/data"
OPTS="-v $MARIADB_DATA:/data"
. ../include/lib
. ../include/debian-pre
/usr/bin/rm -rf $MARIADB_DATA
/usr/bin/mkdir -p $MARIADB_DATA
RUN $APT_GET --no-install-recommends install mariadb-server locales
RUN $APT_GET clean
RUN $APT_GET autoremove
SH "echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen"
RUN /usr/sbin/locale-gen
CLR /tmp
CLR /var/tmp
CLR /var/lib/apt/lists
RUN /usr/bin/chown mysql:mysql /data
RUN /usr/bin/mysql_install_db --user=mysql --basedir=/usr --datadir=/data
RUN /usr/bin/install -m 755 -o mysql -g root -d /var/run/mysqld
CFG --entrypoint '["/usr/sbin/mysqld", "--no-defaults", "--user=mysql", "--basedir=/usr", "--datadir=/data", "--bind-address=127.0.0.1"]'
CFG --cmd ''
CFG --stop-signal TERM
