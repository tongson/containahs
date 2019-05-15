function unit_cleanup() {
    SERVICE="$SVC"
    echo >&2 "Deleting incomplete systemd unit..."
    rm -f "/etc/systemd/system/$SERVICE"
    systemctl daemon-reload
}
trap unit_cleanup 1 2 3 15 ERR

unit_start()
{
    /usr/bin/systemctl daemon-reload
    /usr/bin/systemctl --now enable "$1"
}

unit_install()
{
    cp "$1" /etc/systemd/system
}

unit_active()
{
    /usr/bin/systemctl is-active "$1" && return 0
    return 1
}

unit_image()
{
    name=$(cut -f1 -d: <<< "${1}")
    tag=$(cut -f2 -d: <<< "${1}")
    [ "$name" = "$tag" ] && tag="latest"
    iid=$(/usr/bin/podman images | grep -F -- "/${name} " | grep -F -- " $tag " | awk '{print $3}')
    echo "$iid"
    sed -i "s|__IMAGE__|$iid|" "/etc/systemd/system/${2}"
}

unit_stop()
{
    /usr/bin/systemctl stop "$1" 2>/dev/null || true
    until ! /usr/bin/systemctl is-active --quiet "$1"
    do
      sleep 1
    done
}
