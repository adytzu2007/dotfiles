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

# oh-my-zsh
# clone oh-my-zsh git repo
if [ ! -d $DOTFILES_DIR/oh-my-zsh ]; then
    git clone https://github.com/robbyrussell/oh-my-zsh.git $DOTFILES_DIR/oh-my-zsh
else
    cd $DOTFILES_DIR/oh-my-zsh
    git pull
fi

if [ "$(which zsh)" = "" ]; then
    sudo apt-get install zsh
fi

# change default shell
ok=0
if [ "$(cat /etc/passwd | grep $USER | cut -f7 -d':')" = "/usr/bin/zsh" ]; then
    let ok=1;
fi
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
    else
        rm -rf ${SYMBOLIC_LINKS[$link]}
        ln -s $DOTFILES_DIR/$link ${SYMBOLIC_LINKS[$link]}
    fi
done

# create directories
mkdir -p $HOME/.vim_runtime/undodir

