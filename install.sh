#!/usr/bin/env bash

##
#
# dotfiles installation script
#
##

source ./scripts/base.source
source ./scripts/package_manager.source
debug_on

install_package "zsh"
install_package "tmux"
install_package "gvim"
install_package "git"

default_shell=$(get_default_shell)
if [[ "${default_shell}" != "zsh" ]]; then
    answer=$(prompt_user \
        "Do you want to change your default shell ($default_shell) to zsh?" \
        "yes")
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

SYMBOLIC_LINKS+=(["vim"]="${HOME}/.vim")
SYMBOLIC_LINKS+=(["vimrc"]="${HOME}/.vimrc")
SYMBOLIC_LINKS+=(["vimrc"]=" ${HOME}/.gvimrc")
SYMBOLIC_LINKS+=(["oh-my-zsh"]="${HOME}/.oh-my-zsh")
SYMBOLIC_LINKS+=(["zshrc"]="${HOME}/.zshrc")
SYMBOLIC_LINKS+=(["private"]="${HOME}/.private")
SYMBOLIC_LINKS+=(["gitignore"]="${HOME}/.config/git/ignore")
SYMBOLIC_LINKS+=(["tmux.conf"]="${HOME}/.tmux.conf")

for link in "${!SYMBOLIC_LINKS[@]}"; do
    IFS=" ";
    for destination in ${SYMBOLIC_LINKS[$link]}; do
        if [ -e ${destination} ]; then
            rm -rf ${destination};
        fi
        debug_print "Linking ${DOTFILES_DIR}/$link to ${destination}"
        mkdir -p $(dirname ${destination})
        ln -s -f $DOTFILES_DIR/$link $destination;
    done
done

# create directories
mkdir -p ${HOME}/.vim_runtime/undodir
