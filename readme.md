# dotfiles

Managed with [stow](https://codys.club/blog/2015/07/07/managing-your-dotfiles-with-gnu-stow/).

## Installation

Install `GNU stow` for linux:

```{sh}
sudo apt install stow
```

or for the mac with homebrew (or equivalent with MacPorts):

```{sh}
brew install stow
```
See [documentation](https://www.gnu.org/software/stow/) for more information.

## Usage

Clone repository as:

```{sh}
git clone https://github.com/gcarlino/dotfiles.git ${HOME}/.dotfiles
```

and use `stow` to install **dotfiles**, as:

```{sh}
stow -v nvim
```
