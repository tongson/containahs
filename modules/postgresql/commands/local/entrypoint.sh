#!/bin/sh
exec /usr/lib/postgresql/__POSTGRESQL__/bin/postgres -c data_directory=/data -D /etc/postgresql/__POSTGRESQL__/main -d 5
