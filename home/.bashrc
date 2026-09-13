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
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

### Prompt
export POWERLINE_CONFIG_COMMAND=powerline-config
if [ -f /usr/share/powerline/bindings/bash/powerline.sh ]; then
    source /usr/share/powerline/bindings/bash/powerline.sh
fi

### Colours
if [ -x /usr/bin/dircolors ]; then
    if [ -r ~/.config/dircolors/current ]; then
        eval "$(dircolors -b ~/.config/dircolors/current)"
    else
        eval "$(dircolors -b)"
    fi

    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

### Aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias .='pwd'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cpclip='xclip -o | xclip -sel clip'

## tmux
alias tmux='TERM=screen-256color-bce tmux'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

### Functions
function _command_exists {
    command -v "$1" &> /dev/null
}

# current date to mark files
function datename { date "+%Y-%m-%d_%H-%M-%S"; }

# current git branch
function branch { git name-rev --name-only HEAD; }

# Safe git push force
function push_force {
    local dest_branch=$(branch)
    if test -z "$dest_branch"; then
        echo "No current branch"
        return 1
    fi
    set -x
    git push origin "$dest_branch" --force-with-lease
    set +x
}

# Nicer interactive rebase
function autorebase {
    git rebase --interactive --autosquash --autostash --keep-empty $@
}

# Open arbitrary uri
function go {
    local openers="xdg-open gnome-open"
    for opener in $openers; do
        if _command_exists "$opener"; then
            $opener $@
            return
        fi
    done

    echo "No available opener program: $openers"
    return 1
}

### Syntax highlighting
declare _highlight_command="highlight --out-format xterm256 --style zellner --failsafe --quiet"

function ccat {
    $_highlight_command $@
}

function cless {
    ccat $@ | less -R
}

function files {
    fzf --preview "$_highlight_command {}"
}

### Clipboard
function clip {
    xsel --input --clipboard --keep
}

function unclip {
    xsel --output --clipboard
}

### Text
function mdlist {
    sed -e 's/^\s\+/- /g'
}

### Completion
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

function _git_list_branches {
    # Removing the leading space and f*** asterisk
    git branch --list --all --no-merged | cut -c 3-
}

function _fzf_complete_git_branches {
    _fzf_complete "--reverse --multi" "$@" < <(_git_list_branches)
}

### virtualenvwrapper
export WORKON_HOME="$HOME/.virtualenvs"
VIRTUALENVWRAPPER_SCRIPT=/usr/share/virtualenvwrapper/virtualenvwrapper.sh
[ -f $VIRTUALENVWRAPPER_SCRIPT ] && source $VIRTUALENVWRAPPER_SCRIPT

# create virtualenv from project directory
function mkvenv {
    local name=$(basename $PWD)
    echo Creating virtualenv $name
    mkvirtualenv -a $PWD $@ $name;
}

### fuzzyfinder
FZF_COMPLETION_PATH=$(realpath ~/.fzf/shell/completion.bash 2>/dev/null)
if [ -n "$FZF_COMPLETION_PATH" ] && [ -f "$FZF_COMPLETION_PATH" ]; then
    source "$FZF_COMPLETION_PATH"
fi
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# disable tmux integration
export FZF_TMUX=0
export FZF_DEFAULT_COMMAND='ag --hidden -g "" --ignore "**.pyc" --ignore "**.deb" --ignore ".cache" --ignore ".tox" --ignore ".git" --ignore "**.egg-info" --ignore ".ropeproject"'

### node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Set console in vi mode
set -o vi
