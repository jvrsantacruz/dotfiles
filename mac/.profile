# ~/.profile: executed by the command interpreter for login shells.

export JVR_ENV=mac

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export EDITOR=nvim
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

if [ -f "$HOME/.cache/dogbrew-init.sh" ] && [ "/opt/dogbrew/bin/dogbrew" -nt "$HOME/.cache/dogbrew-init.sh" ] && [ $(date +%s) -lt $(( $(stat -f %m "$HOME/.cache/dogbrew-init.sh") + 604800 )) ]; then
  source "$HOME/.cache/dogbrew-init.sh"
else
  mkdir -p "$HOME/.cache"
  /opt/dogbrew/bin/dogbrew init sh > "$HOME/.cache/dogbrew-init.sh" 2>/dev/null
  source "$HOME/.cache/dogbrew-init.sh"
fi
