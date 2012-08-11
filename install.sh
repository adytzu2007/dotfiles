#!/bin/bash

################################
# dotfiles installation
################################

###
# Debug
###
#set -x # comment to disable debug

# functions
function is_installed
{
    # this function searches the paths below to find a certain program
    local search_path=/bin:/usr/bin:/usr/local/bin

    if [[ "$#" != "1" ]]; then
        echo "usage : $FUNC_NAME program_name"
    fi

    local program_name="$1"
    local IFS=":"
    for directory in ${search_path}; do
        if [[ -d ${directory} ]] && [[ -f ${directory}/${program_name} ]]; then
            echo "yes"
            return 0
        fi
    done

    echo "no"
    return 1
}

function get_full_path
{
    # this function searches the paths below to find a certain program
    local search_path=/bin:/usr/bin:/usr/local/bin

    if [[ "$#" != "1" ]]; then
        echo "usage : $FUNC_NAME program_name"
    fi

    local program_name="$1"
    local IFS=":"
    for directory in ${search_path}; do
        if [[ -d ${directory} ]] && [[ -f ${directory}/${program_name} ]]; then
            echo "${directory}/${program_name}"
            return 0
        fi
    done

    return 1
}

function get_shell
{
    echo $(basename $SHELL)
}

# variables
HAS_VIM=$(is_installed "vim")
HAS_GVIM=$(is_installed "gvim")
HAS_TERMINATOR=$(is_installed "terminator")
HAS_ZSH=$(is_installed "zsh")
DOTFILES_DIR=$HOME/.dotfiles

# oh-my-zsh
# clone oh-my-zsh git repo
if [ ! -d $DOTFILES_DIR/oh-my-zsh ]; then
    git clone https://github.com/robbyrussell/oh-my-zsh.git $DOTFILES_DIR/oh-my-zsh
else
    cd $DOTFILES_DIR/oh-my-zsh
    git pull
fi

if [ "${HAS_ZSH}" = "no" ]; then
    sudo apt-get install zsh || sudo pacman -S zsh
fi

HAS_ZSH=$(is_installed "zsh")

if [[ "$HAS_ZSH" = "yes" ]] && [[ "$(get_shell)" != "zsh" ]]; then
    # change default shel
    read -p "Do you want to change your default shell ($(get_shell)) to zsh? (yes/no) " answer
    if [[ "${answer}" = "yes" ]]; then
        local zsh_full_pash=$(get_full_path "zsh")
        chsh -s ${zsh_full_path}
    fi
fi

# symbolic links
declare -A SYMBOLIC_LINKS
if [[ "${HAS_VIM}" = "yes" ]]; then
    SYMBOLIC_LINKS=(["vim"]="$HOME/.vim")
    SYMBOLIC_LINKS+=(["vimrc"]="$HOME/.vimrc")
fi
if [[ "${HAS_GVIM}" = "yes" ]]; then
    SYMBOLIC_LINKS+=(["gvimrc"]="$HOME/.gvimrc")
fi
if [[ "${HAS_TERMINATOR}" = "yes" ]]; then
    mkdir -p $HOME/.config/terminator
    SYMBOLIC_LINKS+=(["terminator"]="$HOME/.config/terminator/config")
fi
if [[ "${HAS_ZSH}" = "yes" ]]; then
    SYMBOLIC_LINKS+=(["oh-my-zsh"]="$HOME/.oh-my-zsh")
    SYMBOLIC_LINKS+=(["zshrc"]="$HOME/.zshrc")
    SYMBOLIC_LINKS+=(["private"]="$HOME/.private")
fi

# make symbolic links in $HOME
for link in "${!SYMBOLIC_LINKS[@]}"; do
    if [ ! -e ${SYMBOLIC_LINKS[$link]} ]; then
        ln -s $DOTFILES_DIR/$link ${SYMBOLIC_LINKS[$link]}
    else
        rm -rf ${SYMBOLIC_LINKS[$link]}
        ln -s $DOTFILES_DIR/$link ${SYMBOLIC_LINKS[$link]}
    fi
done

# create directories
mkdir -p $HOME/.vim_runtime/undodir

