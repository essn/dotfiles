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

Note:

You may need to install asdf separately until submodules are worked out.

    git clone git@github.com:asdf-vm/asdf.git ~/dotfiles/asdf/.asdf

Install the dotfiles:

    cd dotfiles && stow .

TODO
------

- [ ] More detailed list of software
- [ ] OSX System Preferences script
- [ ] Init script to install brew and related packages
- [ ] List of creditors
- [ ] Add VIM
- [ ] Fix submodules
