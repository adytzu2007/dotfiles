# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="miloshadzic"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots
# to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load?
# (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(archlinux history-substring-search)

. $ZSH/oh-my-zsh.sh

# Put any proprietary or private functions/values in ~/.private,
# and this will source them
if [ -f $HOME/.private ]; then
    . $HOME/.private
fi

if [ -f $HOME/.profile ]; then
    . $HOME/.profile  # Read Mac .profile, if present.
fi

# Shell Aliases
## Git Aliases
#alias gs='git status '
#alias ga='git add '
#alias gb='git branch '
#alias gc='git commit'
#alias gd='git diff'
#alias go='git checkout '
#alias gk='gitk --all&'
#alias gx='gitx --all'
#alias got='git '
#alias get='git '

# qfind - used to quickly find files that contain a string in a directory
qfind () {
    find . -exec grep -l $1 {} \;
    return 0
}

# Custom exports
## Set EDITOR to /usr/bin/vim if Vim is installed
if [ -f /usr/bin/vim ]; then
    export EDITOR=/usr/bin/vim
fi

export ABSROOT=${HOME}/work/packages/arch/abs

alias ipmi='ipmitool -I lanplus -U root -f ~/.racpasswd -H'

isol() {
    if [[ -n $1 ]]; then
        ipmitool -I lanplus -U root -f ~/.racpasswd -H $1 sol activate
    else
        echo "usage: isol <sol_ip>"
    fi
}

repo2sm() {
    if [[ $# -ne 1 ]]; then
        echo "Usage: $0 repo_to_convert"
    fi

    repo_dir=$1
    pushd ${repo_dir}
    repo_url=$(git remote -v | grep fetch | head -n 1 | awk '{print $2}')
    popd
    git rm -r --cached ${repo_dir}
    git submodule add ${repo_url} ${repo_dir}
}

p4opened() {
   if [ $# -ne 1 ]; then
      return 1
   fi

   client_files=$(p4 opened -c $1 | cut -f1 -d' ' | sed 's/\#[0-9]*$//g')

   client_info=$(p4 client -o)

   client=$(echo ${client_info} | grep "^Client:" | sed -r 's/Client:\s+(.*)/\1/g')
   root=$(echo ${client_info} | grep "^Root:" | sed -r 's/Root:\s+(.*)/\1/g')
   views=$(echo ${client_info} | grep "//depot")

   local IFS=$'\n'
   for view in $(echo ${views}); do
      IFS=$'\t '
      echo ${view} | read depot_remote depot_local
      depot_remote=${depot_remote%/...}
      depot_remote=${depot_remote#+}
      depot_local=${depot_local%/...}
      absolute_local=$(echo ${depot_local} | sed "s,//${client},${root},g")
      client_files=$(echo ${client_files} | \
                     sed "s,${depot_remote},${absolute_local},g")
      IFS=$'\n'
   done

   echo ${client_files}
}

meteor() {
    METEOR="${HOME}/work/open-source/meteor/meteor"
    ${METEOR} $@
}

source ~/.work_env/base.source
