#!/bin/bash

################################
# dotfiles installation
################################

###
# Debug
###
set -x # comment to disable debug

# variables
DOTFILES_DIR=$HOME/.dotfiles

declare -A SYMBOLIC_LINKS
SYMBOLIC_LINKS=(["vim"]="$HOME/.vim")
SYMBOLIC_LINKS+=(["vimrc"]="$HOME/.vimrc")
SYMBOLIC_LINKS+=(["terminator"]="$HOME/.config/terminator/config")

# make symbolic links in $HOME
for link in "${!SYMBOLIC_LINKS[@]}"; do
    if [ ! -e ${SYMBOLIC_LINKS[$link]} ]; then
        ln -s $DOTFILES_DIR/$link ${SYMBOLIC_LINKS[$link]}
    fi
done

# create directories
mkdir -p $HOME/.vim_runtime/undodir

