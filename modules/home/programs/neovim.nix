{ config, lib, dotfilesDir, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = false; # editor selection handled in zsh.nix
    withRuby = false;      # managed via mise
    withPython3 = false;   # managed via mise
  };

  # Out-of-store symlink so edits to nvim/ take effect immediately without rebuilding.
  # Uses home.activation rather than xdg.configFile because home-manager recurses into
  # directory sources and fails its $HOME boundary check on the individual files found.
  home.activation.nvimConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    nvim_config="${config.xdg.configHome}/nvim"
    nvim_source="${dotfilesDir}/modules/home/programs/nvim"
    if [ ! -L "$nvim_config" ] || [ "$(readlink "$nvim_config")" != "$nvim_source" ]; then
      $DRY_RUN_CMD rm -rf "$nvim_config"
      $DRY_RUN_CMD ln -sf "$nvim_source" "$nvim_config"
    fi
  '';
}
