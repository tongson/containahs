#!/usr/bin/env moon
buildah = require"buildah"
buildah.from "docker://docker.io/library/php:7.4-cli-alpine", "phpstan"
RUN         "/sbin/apk upgrade --no-cache --available --no-progress"
RUN         "/sbin/apk add git"
RM          "/var/cache/apk"
COPY        "99_memory-limit.ini", "/usr/local/etc/php/conf.d"
-- Composer 1.9.3
COPY        "composer-setup.php"
RUN         "php /composer-setup.php --install-dir=/usr/bin --filename=composer"
RM          "/composer-setup.php"
RUN         "composer global require phpstan/phpstan:#{arg[1]}"
ENTRYPOINT  "/root/.composer/vendor/bin/phpstan"
STORAGE     "phpstan"
