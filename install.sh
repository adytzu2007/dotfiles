#!/usr/bin/env bash

##
#
# dotfiles installation script
#
##

source ./scripts/base.inc.sh
debug_on

# oh-my-zsh
# clone oh-my-zsh git repo
if [ ! -d ${DOTFILES_DIR}/oh-my-zsh ]; then
    debug_print "Cloning oh-my-zsh repo"
    git clone https://github.com/adytzu2007/oh-my-zsh.git ${DOTFILES_DIR}/oh-my-zsh
else
    debug_print "Pulling from oh-my-zsh repo"
    cd ${DOTFILES_DIR}/oh-my-zsh
    git pull
fi

if ! hash "zsh" > /dev/null; then
    debug_print "Installing zsh"
    sudo apt-get install zsh || sudo pacman -S zsh
fi

if hash "zsh" > /dev/null && [[ "$(get_default_shell)" != "zsh" ]]; then
    # change default shell
    answer=$(prompt_user "Do you want to change your default shell ($(get_shell)) to zsh?" "yes")
    if [[ "${answer}" = "yes" ]]; then
        debug_print "Changing default shell to zsh"
        zsh_full_path=$(get_full_path "zsh")
        chsh -s ${zsh_full_path}
    fi
fi

# symbolic links
# SYMBOLIC_LINKS is an associative array
#   key = file name
#   value = where to link (supports multiple locations)
# example:
#   SYMBOLIC_LINKS+=(["file"]="location1 location2")
#   SYMOBLIC_LINKS+=(["file"]=" location3")
#   notice that the space is needed as the values will be appended
declare -A SYMBOLIC_LINKS

if hash "vim" > /dev/null; then
    debug_print "ViM is installed"
    SYMBOLIC_LINKS+=(["vim"]="${HOME}/.vim")
    SYMBOLIC_LINKS+=(["vimrc"]="${HOME}/.vimrc")
fi
if hash "gvim" > /dev/null; then
    debug_print "GViM is installed"
    SYMBOLIC_LINKS+=(["vimrc"]=" ${HOME}/.gvimrc")
fi
if hash "terminator" > /dev/null; then
    debug_print "Terminator is installed"
    mkdir -p ${HOME}/.config/terminator
    SYMBOLIC_LINKS+=(["terminator"]="${HOME}/.config/terminator/config")
fi
if hash "zsh" > /dev/null; then
    debug_print "Zsh is installed"
    SYMBOLIC_LINKS+=(["oh-my-zsh"]="${HOME}/.oh-my-zsh")
    SYMBOLIC_LINKS+=(["zshrc"]="${HOME}/.zshrc")
    SYMBOLIC_LINKS+=(["private"]="${HOME}/.private")
fi
if hash "git" > /dev/null; then
    debug_print "Git is installed"
    SYMBOLIC_LINKS+=(["gitignore_global"]="${HOME}/.gitignore_global")
fi

# make symbolic links in $HOME
for link in "${!SYMBOLIC_LINKS[@]}"; do
    IFS=" ";
    for destination in ${SYMBOLIC_LINKS[$link]}; do
        if [ -e ${destination} ]; then
            rm -rf ${destination};
        fi
        debug_print "Linking ${DOTFILES_DIR}/$link to ${destination}"
        ln -s -f $DOTFILES_DIR/$link $destination;
    done
done

# create directories
mkdir -p ${HOME}/.vim_runtime/undodir
