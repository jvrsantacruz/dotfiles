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
| `lab` | `jvrlab`, Lenovo T480 | kickstarted from `home`, minus the gitlab config; plus `etc/`, see [Caps Lock as F9](#caps-lock-as-f9-lab) |
| `mac` | work macbook | `.zshrc.user`, `.profile`, `.tmux.conf`, `.vimrc`, `.config/{nvim,avante}` |

`common/` holds what is identical on more than one machine, one copy. A profile
takes an entry by linking it in, relatively, so the link resolves the same in a
fresh clone:

    home/.config/git/hooks/pre-commit -> ../../../../common/.config/git/hooks/pre-commit
    lab/.config/git/hooks/pre-commit  -> ../../../../common/.config/git/hooks/pre-commit

`common/` is never stowed itself; the profile is. A machine that should not
have an entry simply does not link it, which is how `mac` has no commit hook.

The environment name is not repeated by hand. `JVR_ENV` holds it, exported from
each profile's `.profile` (and `mac/.zshrc.user`, since zsh does not read
`.profile`), and is the source of truth.

`home` and `lab` both carry an `etc/`, the only part not stowed into `$HOME` —
it belongs in `/etc` and needs root, so `.stow-local-ignore` keeps it out. It
holds the Caps Lock → F9 hwdb rule, matched to the XPS keyboard on `home` and to
the T480 on `lab`.

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

## Caps Lock as F9 (lab)

tmux takes F9 as its prefix, and Caps Lock is remapped to F9 in the kernel
input layer by a udev hwdb rule. Doing it there means it applies before the
compositor, so it holds under Wayland, Xorg and the bare TTY without any
session hook. `~/.Xmodmap` used to do this and no longer can: GNOME reset it
at session start on Xorg, and on Wayland xmodmap cannot apply at all. GNOME
Settings cannot express it either, since `xkb-options` only offers the canned
`caps:escape` / `caps:ctrl_modifier` choices.

`lab/etc/` is the one part of the profile that is not stowed -- it belongs in
`/etc` and needs root, so `.stow-local-ignore` keeps it out of `$HOME`:

```
sudo install -m644 lab/etc/udev/hwdb.d/70-thinkpad-t480-caps-f9.hwdb /etc/udev/hwdb.d/
sudo systemd-hwdb update
sudo udevadm trigger --subsystem-match=input --action=change
```

Check it took, then just press Caps Lock:

```
udevadm info --query=property --name=/dev/input/by-path/platform-i8042-serio-0-event-kbd | grep KEYBOARD_KEY
```

The DMI match is specific to the T480, so the file is inert on other machines.
Note this remaps the keyboard attached to the box: over NoMachine the client
sends keysyms directly, so Caps Lock has to be remapped on the client instead.

## Unversioned

```
ln -s .config/nvim  .vim
```
