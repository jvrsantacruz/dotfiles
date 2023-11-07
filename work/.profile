# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/sbin" ] ; then
    PATH="$HOME/.local/sbin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.gvm/bin" ] ; then
    PATH="$HOME/.gvm/bin:$PATH"
fi

if [ -d "/opt/puppetlabs/bin" ]; then
	PATH="/opt/puppetlabs/bin:$PATH"
fi

export EDITOR=nvim
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export CHEATCOLORS=true
export DEBEMAIL='javier.santacruz@avature.net'
export DEBFULLNAME='Javier Santacruz'
