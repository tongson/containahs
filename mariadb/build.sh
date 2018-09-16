#!/bin/sh
set -efu
NAME="mariadb-build"
IMAGE="debian:testing-slim"
. ../include/lib
MARIADB_DATA="/srv/mariadb/data"
APT_GET="/usr/bin/env DEBIAN_FRONTEND=noninteractive apt-get -qq"
/usr/bin/rm -rf $MARIADB_DATA
/usr/bin/mkdir -p $MARIADB_DATA
$MKDIR /usr/share/man/man1
$RUN /usr/bin/touch /usr/share/man/man1/sh.distrib.1.gz
$RUN $APT_GET update
$RUN $APT_GET dist-upgrade
$RUN $APT_GET --no-install-recommends install mariadb-server locales
$RUN $APT_GET clean
$RUN $APT_GET autoremove
$CSH "echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen"
$RUN /usr/sbin/locale-gen
$CLEAN /tmp
$CLEAN /var/tmp
$CLEAN /var/lib/apt/lists
/usr/bin/buildah run -v $MARIADB_DATA:/data $__CONTAINER -- /usr/bin/chown mysql:mysql /data
/usr/bin/buildah run -v $MARIADB_DATA:/data $__CONTAINER -- /usr/bin/mysql_install_db --user=mysql --basedir=/usr --datadir=/data
$RUN /usr/bin/install -m 755 -o mysql -g root -d /var/run/mysqld
$CONFIG --entrypoint '["/usr/sbin/mysqld", "--no-defaults", "--user=mysql", "--basedir=/usr", "--datadir=/data", "--bind-address=127.0.0.1"]'
$CONFIG --cmd ''
$CONFIG --stop-signal TERM
