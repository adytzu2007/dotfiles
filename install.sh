#!/bin/bash

################################
# dotfiles installation
################################

###
# Debug
###
set -x # comment to disable debug

# oh-my-zsh
# clone oh-my-zsh git repo
git clone git://github.com/robbyrussell/oh-my-zsh.git
apt-get install zsh

# change default shell
ok=0
while [ "$ok" = "0" ]; do
    echo "Do you want to change your shell to zsh? (yes/no)"
    read choice
    if [ "$choice" = "yes" ]; then
        chsh -s /usr/bin/zsh
        ok=1
    elif [ "$choice" = "no" ]; then
        echo "Did not change the shell"
        ok=1
    else
        echo "Please answer with yes or no!"
    fi
done

# variables
DOTFILES_DIR=$HOME/.dotfiles

# symbolic links
declare -A SYMBOLIC_LINKS
SYMBOLIC_LINKS=(["vim"]="$HOME/.vim")
SYMBOLIC_LINKS+=(["vimrc"]="$HOME/.vimrc")
SYMBOLIC_LINKS+=(["gvimrc"]="$HOME/.gvimrc")
SYMBOLIC_LINKS+=(["terminator"]="$HOME/.config/terminator/config")
SYMBOLIC_LINKS+=(["oh-my-zsh"]="$HOME/.oh-my-zsh")
SYMBOLIC_LINKS+=(["zshrc"]="$HOME/.zshrc")

# make symbolic links in $HOME
for link in "${!SYMBOLIC_LINKS[@]}"; do
    if [ ! -e ${SYMBOLIC_LINKS[$link]} ]; then
        ln -s $DOTFILES_DIR/$link ${SYMBOLIC_LINKS[$link]}
    fi
done

# create directories
mkdir -p $HOME/.vim_runtime/undodir

