# dotfiles

My dotfiles for work and pleasure

## Profiles

One directory per environment, activated on a machine with GNU stow. The same
division as `~/.skills` (`jvrsantacruz/skills`, Claude configuration) and
`~/dev/lab/infra` (`jvrsantacruz/lab`, provisioning), so one name covers a
machine's whole setup.

| Profile | Machine | Notable contents |
|---|---|---|
| `home` | `dlap`, Dell XPS 13 9370 | `.bashrc`, `.profile`, `.gitconfig`, `.tmux.conf`, `.xinitrc`, `.Xmodmap`, `.config/{nvim,powerline,dircolors}`, `etc/` |
| `lab` | `jvrlab`, Lenovo T480 | kickstarted from `home`, minus the gitlab config |
| `mac` | work macbook | `.zshrc.user`, `.profile`, `.tmux.conf`, `.vimrc`, `.config/{nvim,avante}` |

The environment name is not repeated by hand. `JVR_ENV` holds it, exported from
each profile's `.profile` (and `mac/.zshrc.user`, since zsh does not read
`.profile`), and is the source of truth.

`home` and `lab` also carry an `etc/`, the only part not stowed into `$HOME` —
it belongs in `/etc` and needs root, so `.stow-local-ignore` keeps it out. On
`home` that is the Caps Lock → F9 hwdb rule for the XPS keyboard.

Not in the repo: `.zshrc.env` (secrets).

## Install

```
# Clone the repo
git clone git@github.com:jvrsantacruz/dotfiles ~/.dotfiles
# Enable environment: stow the profile for this machine
cd ~/.dotfiles && stow "$JVR_ENV"
```

On a fresh machine `JVR_ENV` is unset, because the `.profile` that exports it is
what is about to be stowed. Bootstrap types the name once:

```
cd ~/.dotfiles && stow home
```

## Unversioned

```
ln -s .config/nvim  .vim
```
