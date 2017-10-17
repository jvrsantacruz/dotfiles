# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.local/share/.dir_colors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    eval $(dircolors ~/.config/dircolors/current)
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias .='pwd'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cpclip='xclip -o | xclip -sel clip'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

function mkcd { mkdir $1 && cd $1; }

# shorthand for vagrant
function v { vagrant $@; }

# recreate vagrant environment
function revagrant { vagrant destroy -f $1 && vagrant up $1; alert "finished creation of $1"; }

# create virtualenv from project directory
function mkvenv { 
    local name=$(basename $PWD)
    echo Creating virtualenv $name
    mkvirtualenv -a $PWD $@ $name;
}

# clone avature gitlab project
function gclone { git clone git@gitlab.xcade.net:avature/$1 $2; }

# current git branch
function branch { git name-rev --name-only HEAD; }

# current date to mark files
function datename { date "+%Y-%m-%d_%H-%M-%S"; }

# go to sandbox home directory
function cdsbxr {
    local name=$1
    local path=$(sbxr list --columns "Vagrant directory" --no-header --format plain --name $name)
    echo $path
    cd $path
}

# lxd copy directories recursively
function lxc_cp {
    local name="$1"
    local src="$2"
    local dst="$3"

    tar cz "$src" | lxc exec "$name" tar xzf - "$dest"
}

function cr {
    local branch="$1"
    iatsCR -d gitlab $branch
}

function _command_exists {
    command -v "$1" &> /dev/null
}

function go {
    local openers="xdg-open" "gnome-open"
    for opener in $openers; do
        if _command_exists "$opener"; then
            $opener $@
            return
        fi
    done

    echo "No available opener program: $openers"
    exit 1
}

function gitlab {
    local name=${1:-$(basename $(readlink -f .))}
    local user=${2:-avature}

    go https://gitlab.xcade.net/$user/$name
}

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Virtualenvwrapper (Ubuntu)
# This should be enabled when bash_completion is, but it doesn't
#if ! type workon &> /dev/null; then
#    source /etc/bash_completion.d/virtualenvwrapper
#fi

# Powerline
export POWERLINE_CONFIG_COMMAND=powerline-config
if [ -f ~/.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh  ]; then
	source ~/.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
fi

# Force keyboard bindings evaluation
xmodmap ~/.Xmodmap

## fuzzyfinder
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# disable tmux integration
export FZF_TMUX=0

## rvm
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

## tmux
alias tmux='TERM=screen-256color-bce tmux'

# Set console in vi mode
set -o vi
