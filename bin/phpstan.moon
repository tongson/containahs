#!/usr/bin/env moon
cli = require "cliargs"
cli\option "-v, --version=VERSION", "PHPSTAN version"
cli\set_name "phpstan"
argu = cli\parse(args)
if not argu
    cli\print_help!
    os.exit(0)
if not argu.version
    cli\print_help!
    os.exit(1)

base = "docker://docker.io/library/php:7.4-cli-alpine"
assets = "phpstan.d"
phpstan = ->
    RUN         "/sbin/apk upgrade --no-cache --available --no-progress"
    RUN         "/sbin/apk add git"
    RM          "/var/cache/apk"
    COPY        "99_memory-limit.ini", "/usr/local/etc/php/conf.d"
    -- Composer 1.9.3
    COPY        "composer-setup.php"
    RUN         "php /composer-setup.php --install-dir=/usr/bin --filename=composer"
    RM          "/composer-setup.php"
    RUN         "composer global require phpstan/phpstan:#{argu.version}"
    ENTRYPOINT  "phpstan"
    STORAGE     "phpstan"
buildah = require"buildah".from base ,phpstan, assets
buildah!
