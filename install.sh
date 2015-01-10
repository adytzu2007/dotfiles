#!/usr/bin/env bash

##
#
# dotfiles installation script
#
##

# location where the dotfiles repository is installed
DOTFILES_DIR="$(readlink -f $(dirname $0))"

SCRIPTS_DIR=${DOTFILES_DIR}/scripts
INSTALL_DIR=${DOTFILES_DIR}/install

source ${SCRIPTS_DIR}/base.source
source ${SCRIPTS_DIR}/package_manager.source
debug_on

# symbolic links
# SYMBOLIC_LINKS is an associative array
#   key = file name
#   value = where to link (supports multiple locations)
# example:
#   SYMBOLIC_LINKS+=(["file"]="location1 location2")
#   SYMOBLIC_LINKS+=(["file"]=" location3")
#   notice that the space is needed as the values will be appended
#
#   each folder from the install directory should have an install.source
#   file that defines how the contents should be installed
declare -A SYMBOLIC_LINKS

for package in ${INSTALL_DIR}/*; do
    if [[ -f ${package}/install.source ]]; then
        source ${package}/install.source
    else
        debug_print "Warning (package ${package}): missing install.source"
    fi
done

for link in "${!SYMBOLIC_LINKS[@]}"; do
    for destination in "${SYMBOLIC_LINKS[$link]}"; do
        if [[ -e ${destination} ]]; then
            echo "Link destination already exists."
            answer=$(prompt_user \
                "Are you sure you want to overwrite? (yes/no)"
                "yes")
            if [[ ${answer} = "yes" ]]; then
                echo "Moving ${destination} to ${destination}.bak"
                mv ${destination} ${destination}.bak
            else
                continue
            fi
        fi
        debug_print "Linking ${DOTFILES_DIR}/$link to ${destination}"
        mkdir -p $(dirname ${destination})
        ln -s -f $DOTFILES_DIR/${link} ${destination}
    done
done


