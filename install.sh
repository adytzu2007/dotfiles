#!/bin/bash

################################
# dotfiles installation
################################

###
# Debug
###
set -x # comment to disable debug

# functions
function get_full_path
{
    # this function searches the paths below to find a certain program
    local search_path=/bin:/usr/bin:/usr/local/bin;

    if [[ "$#" != "1" ]]; then
        echo "usage : $FUNC_NAME program_name";
    fi

    local program_name="$1";
    local IFS=":";
    for directory in ${search_path}; do
        if [[ -d ${directory} ]] && [[ -f ${directory}/${program_name} ]]; then
            echo "${directory}/${program_name}";
            return 0;
        fi
    done

    return 1;
}

function get_shell
{
    echo $(basename $SHELL);
}

function prompt_user
{
    if [[ "$#" != "2" ]]; then
        echo "usage : $FUNC_NAME prompt_value default_value";
    fi

    local prompt_value=$1;
    local default_value=$2;
    read -p "$prompt_value [$default_value] :" answer
    if [[ "$answer" = "" ]]; then
        answer=$default_value
    fi

    echo $answer
}

# variables
DOTFILES_DIR=$HOME/.dotfiles

# oh-my-zsh
# clone oh-my-zsh git repo
if [ ! -d $DOTFILES_DIR/oh-my-zsh ]; then
    git clone https://github.com/robbyrussell/oh-my-zsh.git $DOTFILES_DIR/oh-my-zsh
else
    cd $DOTFILES_DIR/oh-my-zsh
    git pull
fi

if ! get_full_path "zsh"; then
    sudo apt-get install zsh || sudo pacman -S zsh
fi

if get_full_path "zsh" && [[ "$(get_shell)" != "zsh" ]]; then
    # change default shell
    answer=$(prompt_user "Do you want to change your default shell ($(get_shell)) to zsh?" "yes")
    if [[ "${answer}" = "yes" ]]; then
        zsh_full_path=$(get_full_path "zsh")
        chsh -s ${zsh_full_path}
    fi
fi

# symbolic links
declare -A SYMBOLIC_LINKS
if get_full_path "vim"; then
    SYMBOLIC_LINKS=(["vim"]="$HOME/.vim")
    SYMBOLIC_LINKS+=(["vimrc"]="$HOME/.vimrc")
fi
if get_full_path "gvim"; then
    SYMBOLIC_LINKS+=(["vimrc"]=" $HOME/.gvimrc")
fi
if get_full_path "terminator"; then
    mkdir -p $HOME/.config/terminator
    SYMBOLIC_LINKS+=(["terminator"]="$HOME/.config/terminator/config")
fi
if get_full_path "zsh"; then
    SYMBOLIC_LINKS+=(["oh-my-zsh"]="$HOME/.oh-my-zsh")
    SYMBOLIC_LINKS+=(["zshrc"]="$HOME/.zshrc")
    SYMBOLIC_LINKS+=(["private"]="$HOME/.private")
fi

# make symbolic links in $HOME
for link in "${!SYMBOLIC_LINKS[@]}"; do
    backup_ifs=$IFS;
    IFS=" ";
    for destination in ${SYMBOLIC_LINKS[$link]}; do
        if [ -e $destination ]; then
            rm -rf $destination;
        fi
        ln -s $DOTFILES_DIR/$link $destination;
    done
    IFS=$backup
done

# create directories
mkdir -p $HOME/.vim_runtime/undodir

