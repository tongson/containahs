# Generated by stubbs:add-option. Do not edit, if using stubbs.
# Created: Fri Dec  7 15:39:23 HKT 2018
#
#/ usage: postgresql:useradd  --user <"">  --address <""> [ --postgresql <"9.6">] [ --database <"all">] 

# _rerun_options_parse_ - Parse the command arguments and set option variables.
#
#     rerun_options_parse "$@"
#
# Arguments:
#
# * the command options and their arguments
#
# Notes:
#
# * Sets shell variables for any parsed options.
# * The "-?" help argument prints command usage and will exit 2.
# * Return 0 for successful option parse.
#
rerun_options_parse() {
  
    unrecognized_args=()

    while (( "$#" > 0 ))
    do
        OPT="$1"
        case "$OPT" in
            --user) rerun_option_check $# $1; USER=$2 ; shift 2 ;;
            --address) rerun_option_check $# $1; ADDRESS=$2 ; shift 2 ;;
            --postgresql) rerun_option_check $# $1; POSTGRESQL=$2 ; shift 2 ;;
            --database) rerun_option_check $# $1; DATABASE=$2 ; shift 2 ;;
            # help option
            -\?|--help)
                rerun_option_usage
                exit 2
                ;;
            # unrecognized arguments
            *)
              unrecognized_args+=("$OPT")
              shift
              ;;
        esac
    done

    # Set defaultable options.
    [[ -z "$POSTGRESQL" ]] && POSTGRESQL="$(rerun_property_get $RERUN_MODULE_DIR/options/postgresql DEFAULT)"
    [[ -z "$DATABASE" ]] && DATABASE="$(rerun_property_get $RERUN_MODULE_DIR/options/database DEFAULT)"
    # Check required options are set
    [[ -z "$USER" ]] && { echo >&2 "missing required option: --user" ; return 2 ; }
    [[ -z "$ADDRESS" ]] && { echo >&2 "missing required option: --address" ; return 2 ; }
    # If option variables are declared exportable, export them.

    # Make unrecognized command line options available in $_CMD_LINE
    if [ ${#unrecognized_args[@]} -gt 0 ]; then
      export _CMD_LINE="${unrecognized_args[@]}"
    fi
    #
    return 0
}


# If not already set, initialize the options variables to null.
: ${USER:=}
: ${ADDRESS:=}
: ${POSTGRESQL:=}
: ${DATABASE:=}
# Default command line to null if not set
: ${_CMD_LINE:=}


