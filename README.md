# dotfiles

My dotfiles for work and pleasure

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

Unversioned things:
```
ln -s .config/nvim  .vim
```
