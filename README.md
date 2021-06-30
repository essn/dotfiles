essn dotfiles
===================

Meant for use with OSX using system ZSH.

Relies heavily on many influences, but also some of my own making.

Requirements
------------

OSX 10.14 or later

[stow](https://www.gnu.org/software/stow/)

Install
-------

Install Brew:

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

Clone onto your laptop:

    git clone --recurse-submodules git://github.com/essn/dotfiles.git ~/dotfiles

Install the dotfiles:

    cd dotfiles && stow .

TODO
------

- [ ] More detailed list of software
- [ ] OSX System Preferences script
- [ ] Init script to install brew and related packages
- [ ] List of creditors
- [x] Add VIM
- [ ] Make sure that brew auto completions are correctly picked up
- [ ] Get that diff-so-fancy thing from mathias dotfiles
- [ ] SSH / GPG settings. Sign commits and maybe pull keys from a 3rd party?
- [ ] Move as much to ASDF as possible
- [ ] Global tools symlink for brew and ASDF
- [ ] Fix zsh python aliases and asdf python in general
- [x] Change ; ; mapping for nvim
- [x] Add kj mapping for esc in nvim
- [ ] Allow h j k l navigation in tmux panes
- [x] Revisit tmux coloring and status bar
- [x] Fix asdf submodule && make sure lnvim submodule works
- [x] Make sure ranger opens nvim w correct file
- [x] Base16 colors in env?
- [ ] Tmux sources colors from env
- [ ] Nvim sources colors from env
- [ ] Zsh sources colors from env
- [ ] Compatibilty w Linux
- [ ] Fonts install automatically
- [ ] Revisit nvim
