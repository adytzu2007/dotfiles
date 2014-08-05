##
#
# base functions and variables
#
##
DOTFILES_DIR=${HOME}/.dotfiles

function get_full_path
{
    if [[ ! $# -eq 1 ]]; then
        return 1;
    fi

    local path_for=$1

    local IFS=':'
    for dir in ${PATH}; do
        if [[ -x ${dir}/${path_for} ]]; then
            echo ${dir}/${path_for}
            return 0
        fi
    done

    return 1
}

function get_default_shell
{
    shell=$(getent passwd ${USER} | cut -f7 -d':')

    echo $(basename ${shell})
}

function prompt_user
{
    if [[  $# -ne 2 ]]; then
        echo "$FUNC_NAME prompt_value default_value";
    fi

    local prompt_value=$1
    local default_value=$2

    read -p "${prompt_value} [${default_value}] : " answer

    if [[ "${answer}" = "" ]]; then
        answer=${default_value}
    fi

    echo ${answer} | tr A-Z a-z
}

function debug_on
{
    __DEBUG_PRINT__="true"
}

function debug_print
{
    if [[ "${__DEBUG_PRINT__}" = "true" ]]; then
        echo "$*"
    fi
}

function debug_off
{
    unset __DEBUG_PRINT__
}
