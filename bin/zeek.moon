#!/usr/bin/env moon
require"buildah".from "24062c94d7bc", "zeek"
APT_PURGE "sysvinit-utils bash tzdata e2fsprogs e2fslibs util-linux mount login hostname fdisk bsdutils findutils"
APT_GET   "--purge autoremove"
APT_GET   "autoclean"
WIPE      "docs"
WIPE      "directories"
WIPE      "perl"
WIPE      "debian"
WIPE      "userland"
WIPE      "sh"
ENTRYPOINT "/opt/zeek/bin/zeek"
PUSH      "zeek", "3.2.2"
