{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = false; # editor selection handled in zsh.nix
    withRuby = false;      # managed via mise
    withPython3 = false;   # managed via mise
  };

  # Config directory managed as plain files — see nvim/ in this directory.
  # To populate on first setup, copy your existing config:
  #   cp -r ~/.config/nvim modules/home/programs/nvim
  xdg.configFile."nvim" = {
    source = ./nvim;
    recursive = true;
  };
}
