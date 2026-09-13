# ~/.profile: executed by the command interpreter for login shells.

# Which environment this machine is. The source of truth for the name: the
# profile stowed from ~/.dotfiles and ~/.skills, and the directory under
# ~/dev/lab/infra, are all this. Scripts read it instead of being told.
export JVR_ENV=mac

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export EDITOR=nvim
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

eval "$(/opt/dogbrew/bin/dogbrew init sh)"
