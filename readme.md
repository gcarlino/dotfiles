# Managing dotfiles with GNU stow

1. Install `GNU stow` for linux

```{sh}
sudo apt install stow
```

or the mac with homebrew:

```{sh}
brew install stow
```

or equivalent for MacPorts.
See [documentation](https://www.gnu.org/software/stow/) for more information.

2. Clone repository as:

```{sh}
git clone https://github.com/gcarlino/dotfiles.git ${HOME}/.dotfiles
```

3. Use `stow` to install **dotfiles**, as:

```{sh}
stow -v nvim
```
