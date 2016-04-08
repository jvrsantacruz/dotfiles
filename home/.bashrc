# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

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

#if [ -f ~/.git-prompt.sh ]; then
#	source ~/.git-prompt.sh
#fi

function git_branch { 
	echo `__git_ps1 '(%s)'` 
}

function battery { 
	acpi_output=`acpi -p 2> /dev/null`
	sign=
	if [ "`echo $acpi_output | fgrep discharging`" ] ; then
		sign='-'
	elif [ "`echo $acpi_output | fgrep charging`" ] ; then
		sign='+'
	fi

	battery_level=`echo $acpi_output | sed -e 's/.*, \([0-9]\+%\).*/\1/'` 

	if [ "$battery_level" ]; then
		echo "(${sign}${battery_level})"
	fi
}

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h:\w\a\]\$(vcprompt)\$(battery)$PS1"
    ;;
*)
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
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

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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

#alias mvlast='~/./.mvlast.py'
#alias cplist='~/./.cplist.py'
#alias move='rsync -r -v --progress --remove-source-files'
alias copy='rsync -aWr --progress'
alias go='xdg-open'
alias lsat='ls -1t | head'
alias mgrep='fgrep -iHRn '
alias hdate='date +"%d-%m-%Y-%H-%M-%S"'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cpclip='xclip -o | xclip -sel clip'

function setcpugov { for i in 0 1; do cpufreq-selector -c $i -g $1; done }
function getcpugov { cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor; }
function getcpuavailgov { cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors; }
function getcpufreq { cat /proc/cpuinfo | grep "cpu MHz"; }

function mkcd { mkdir $1 && cd $1; }
function cdls { cd $1 && ls; }

# Poner la consola en modo vi
set -o vi

# virtualenvwrapper
export WORKON_HOME="$HOME/.virtualenvs"
source `which virtualenvwrapper.sh`
export PATH=$HOME/.local/bin:$PATH
export EDITOR=vim
