# dotfiles

My dotfiles for work and pleasure

## Profiles

| Profile | Machine | Notable contents |
|---|---|---|
| `mac` | this laptop | `.zshrc.user`, `.profile`, `.tmux.conf`, `.vimrc`, `.config/{nvim,avante}`, `CLAUDE.md` |
| `work` | Linux work | `.bashrc`, `.gitconfig`, `.gitignore-global`, `.quiltrc`, `.local`, `.config/{nvim,powerline,dircolors}` |
| `home` | personal Linux | `.bashrc`, `.gitconfig`, `.hgrc`, `.xinitrc`, `.Xmodmap`, `.config/nvim` |
| `lab` | `jvrlab` homelab | kickstarted from `home`, same contents |

Not in the repo: `.zshrc.env` (secrets), `mac/.claude/` (own repo, `jvrsantacruz/skills`).

## Install

```
# Clone the repo
git clone git@github.com:jvrsantacruz/dotfiles ~/.dotfiles
# Enable environment: stow the profile for this machine
cd ~/.dotfiles && stow <profile>

# e.g. mac laptop
cd ~/.dotfiles && stow mac
# e.g. linux work machine
cd ~/.dotfiles && stow work
```

## Unversioned

```
ln -s .config/nvim  .vim
```
