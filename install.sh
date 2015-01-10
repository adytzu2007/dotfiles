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

git submodule init
git submodule update

source ${SCRIPTS_DIR}/base.source
source ${SCRIPTS_DIR}/package_manager.source
debug_on

for package in ${INSTALL_DIR}/*; do
    if [[ -f ${package}/install.source ]]; then
        PACKAGE_DIR=${package}
        source ${package}/install.source
    else
        debug_print "Warning (package ${package}): missing install.source"
    fi
done
