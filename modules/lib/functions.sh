function RERUN_FUNC_CLEANUP {
    s=$?; echo >&2 "$0: Error on line ${LINENO}: ${BASH_COMMAND}"
    rm -rf "$TMPDIR"
    exit $s
}
trap RERUN_FUNC_CLEANUP 1 2 3 15 ERR

print()
{
    printf '[\e[1;33m+\e[m] \e[1;35m%s\e[m\n' "$@"
}

