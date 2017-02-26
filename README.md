# My dotfiles

This repo contains some of my dotfiles.

## Installation

First, clone the directory in `$HOME`

```bash
$ cd ~
$ git clone git@github.com:koallen/dotfiles.git .dotfiles
```

Then use `stow` to symlink the files into `$HOME` (make sure you have `stow` installed)

```bash
$ cd .dotfiles
$ stow vim
```
